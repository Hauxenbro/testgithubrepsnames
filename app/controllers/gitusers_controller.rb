require "uri"
require "net/http"
require "json"

class GitusersController < ApplicationController
  def index
    @gituser = Gituser.new
  end

  def show
    @log = $log
    @name = $name
    @list = []
    # Параметры для запросов graph
    url_gr = URI("http://127.0.0.1:3000//graphql")
    http = Net::HTTP.new(url_gr.host, url_gr.port);
    request = Net::HTTP::Post.new(url_gr)
    request["Content-Type"] = "application/json"
    request.body = "{\"query\":\"{\\r\\n  gitrepsName(log:\\\"#{$log}\\\"){\\r\\n    name\\r\\n  }\\r\\n}\",\"variables\":{}}"
    response = http.request(request)
    JSON.parse(response.read_body)["data"]["gitrepsName"].each do |x|
      @list << x['name']
    end

  end

  def create

    # Получаем логин из формы
    $log = gituser_params["log"]

    # Получаем из гита имя
    url = URI("https://api.github.com/users/#{$log}")
    response = Net::HTTP.get(url)
    $name = JSON.parse(response)["name"] ? JSON.parse(response)["name"] : "# No Name"

    # параметры для запросов
    url_gr = URI("http://127.0.0.1:3000//graphql")
    http = Net::HTTP.new(url_gr.host, url_gr.port);
    request = Net::HTTP::Post.new(url_gr)
    request["Content-Type"] = "application/json"

    if Gituser.exists?(:log => $log)
      # Если имя изменилось, то перезаписываем его.
      request.body = "{\"query\":\"{\\r\\n  getuserName(log:\\\"#{$log}\\\")\\r\\n  {\\r\\n    log\\r\\n    name\\r\\n  }\\r\\n}\",\"variables\":{}}"
      response = http.request(request)
      name_ch = JSON.parse(response.read_body)["data"]["getuserName"][0]["name"]
      id = Gituser.find_by_log($log).id
      Gitrep.where("gituser": id).delete_all
      if $name != name_ch
        request.body = "{\"query\":\"mutation{\\r\\n  updateGituser(input:{id:\\\"#{id}\\\", attributes:{name:\\\"#{$name}\\\", log:\\\"#{$log}\\\"}}){\\r\\n    gituser{\\r\\n      name\\r\\n      log\\r\\n    }\\r\\n  }\\r\\n}\",\"variables\":{}}"
        http.request(request)
      end
    end


    # Получаем из гита репы
    bad_ans = { "message" => "Not Found", "documentation_url" => "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user" }
    url = URI("https://api.github.com/users/#{$log}/repos")
    response = Net::HTTP.get(url)
    response = JSON.parse(response)
    if response == bad_ans
      response = nil
    else
      # Запись юзера в БД нового, если у него есть репы
      request.body = "{\"query\":\"mutation{\\r\\n  createGituser(input:{log:\\\"#{$log}\\\", name:\\\"#{$name}\\\"}){\\r\\n    gituser{\\r\\n      name\\r\\n    }\\r\\n  }\\r\\n}\\r\\n\",\"variables\":{}}"
      http.request(request)
      response.each do |x|
        request.body = "{\"query\":\"mutation{\\r\\n  createRep(input:{log:\\\"#{$log}\\\", name:\\\"#{x["name"]}\\\"}){\\r\\n    repository{\\r\\n      name\\r\\n    }\\r\\n  }\\r\\n}\",\"variables\":{}}"
        http.request(request)
      end
    end

    if not response.nil?
      @user = Gituser.find_by_log($log)
      redirect_to @user
    else
      redirect_to gitusers_path, alert: "Ваш пользователь не зарегистрирован на github!"
      end

  end

  private

  def gituser_params
    params.require(:gituser).permit(:log)
  end
end
