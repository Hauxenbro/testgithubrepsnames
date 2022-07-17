# frozen_string_literal: true

module Types
  class GituserType < Types::BaseObject
    field :id, ID, null: false
    field :log, String
    field :name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
