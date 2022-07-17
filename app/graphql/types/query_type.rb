module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me

    field :gitreps, [Types::GitrepType], null: false
    def gitreps
      Gitrep.all
    end

    field :gitrepsName, [Types::GitrepType], null: false do
      argument :log, String, required: true
    end
    def gitrepsName(log:)
      user = Gituser.find_by_log(log)
      Gitrep.where(gituser_id: user.id)
    end

    field :getuserName, [Types::GituserType], null: false do
      argument :log, String, required:true
    end
    def getuserName(log:)
      Gituser.where(log: log)
    end
  end
end
