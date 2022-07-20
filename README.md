# GithubReps

Installation:

Start your cmd.exe
1) git clone https://github.com/Hauxenbro/testgithubrepsnames.git
2) cd testgithubrepsnames
3) bundle config --local without "production"
4) bundle install
5) rails s

Endpoints:

localhost:3000/ - index.html.erb => Main form
localhost:3000/graphiql - usage of graphql manually

How to use it:

- Enter localhost:3000/
- Enter github login into the form
- Getting results

Tests:

1) cd testgithubrepsnames
2)
  - rspec spec # full testing
  - rspec spec/models/gituser_spec.rb # tests only for gituser model
  - rspec spec/models/gitrep_spec.rb # tests only for gitrep model
  - rspec spec/requests/gitusers_controller_spec.rb # tests only for gitusers controller

