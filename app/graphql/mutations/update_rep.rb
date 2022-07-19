# frozen_string_literal: true

module Mutations
  # Mutation class for GRAPHQL which updates rep data in Gitrep table in DB
  class UpdateRep < BaseMutation
    # field :post, Types::PostType, null: false
    field :rep, Types::GitrepType, null: false

    # argument :name, String, required: true
    argument :id, ID, required: true
    argument :attributes, Types::GitrepAttributes, required: true

    def resolve(id:, attributes:)
      rep = Gitrep.find(id)
      return { rep: rep } if rep.update(attributes.to_h)

      raise GraphQL::ExecutionError, rep.errors.full_messages.join(', ')
    end
  end
end
