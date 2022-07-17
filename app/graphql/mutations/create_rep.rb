module Mutations
  class CreateRep < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false
    field :repository, Types::GitrepType, null: false

    # TODO: define arguments
    # argument :name, String, required: true
    argument :log, String, required: true
    argument :name, String, required: true

    # TODO: define resolve method
    def resolve(log:, name:)
      user = Gituser.find_by_log(log)
      repository = user.gitreps.new(name: name)
      if repository.save
        {
          repository: repository,
          errors: []
        }
      else
        {
          repository: nil,
          errors: repository.errors.full_messages
        }
      end

    end
  end
end
