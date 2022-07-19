# frozen_string_literal: true

module Types
  # Class for getting queries from DB by using GRAPHQL
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me

    field :git_reps, [Types::GitrepType], null: false
    def git_reps
      Gitrep.all
    end

    field :git_reps_name, [Types::GitrepType], null: false do
      argument :log, String, required: true
    end
    def git_reps_name(log:)
      user = Gituser.find_by_log(log)
      Gitrep.where(gituser_id: user.id)
    end

    field :get_user_name, [Types::GituserType], null: false do
      argument :log, String, required: true
    end
    def get_user_name(log:)
      Gituser.where(log: log)
    end

    field :get_user, [Types::GituserType], null: false do
      argument :id, ID, required: true
    end
    def get_user(id:)
      Gituser.where(id: id)
    end
  end
end
