# frozen_string_literal: true

module Mutations
  # Mutation class for GRAPHQL which creates new user in Gituser table in DB
  class CreateGituser < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false
    field :gituser, Types::GituserType, null: false

    # TODO: define arguments
    # argument :name, String, required: true
    argument :log, String, required: true
    argument :name, String, required: true

    # TODO: define resolve method
    def resolve(log:, name:)
      gituser = Gituser.new(log: log, name: name)
      if gituser.save
        {
          gituser: gituser,
          errors: []
        }
      else
        {
          gituser: nil,
          erros: gituser.errors.full_messages
        }
      end
    end
  end
end
