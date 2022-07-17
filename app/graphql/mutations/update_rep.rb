module Mutations
  class UpdateRep < BaseMutation
    # field :post, Types::PostType, null: false
    field :rep, Types::GitrepType, null: false


    # argument :name, String, required: true
    argument :id, ID, required: true
    argument :attributes, Types::GitrepAttributes, required: true

    def resolve(id:, attributes:)
      rep = Gitrep.find(id)
      if rep.update(attributes.to_h)
        { rep: rep }
      else
        raise GraphQL::ExecutionError, rep.errors.full_messages.join(", ")
      end
    end
  end
end


