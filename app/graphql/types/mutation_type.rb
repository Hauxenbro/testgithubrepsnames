module Types
  class MutationType < Types::BaseObject
    field :update_rep, mutation: Mutations::UpdateRep
    field :update_gituser, mutation: Mutations::UpdateGituser
    field :create_gituser, mutation: Mutations::CreateGituser
    field :create_rep, mutation: Mutations::CreateRep
  end
end
