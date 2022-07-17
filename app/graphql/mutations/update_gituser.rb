module Mutations
  class UpdateGituser < BaseMutation
    # field :post, Types::PostType, null: false
    field :gituser, Types::GituserType, null: false


    # argument :name, String, required: true
    argument :id, ID, required: true
    argument :attributes, Types::GituserAttributes, required: true

    def resolve(id:, attributes:)
      gituser = Gituser.find(id)
      if gituser.update(attributes.to_h)
        { gituser: gituser }
      else
        raise GraphQL::ExecutionError, gituser.errors.full_messages.join(", ")
      end
    end
  end
end

