# frozen_string_literal: true

module Mutations
  # Mutation class for GRAPHQL which updates user data in Gituser table in DB
  class UpdateGituser < BaseMutation
    # field :post, Types::PostType, null: false
    field :gituser, Types::GituserType, null: false

    # argument :name, String, required: true
    argument :id, ID, required: true
    argument :attributes, Types::GituserAttributes, required: true

    def resolve(id:, attributes:)
      gituser = Gituser.find(id)
      return { gituser: gituser } if gituser.update(attributes.to_h)

      raise GraphQL::ExecutionError, gituser.errors.full_messages.join(', ')
    end
  end
end
