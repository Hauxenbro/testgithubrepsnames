module Types
  class GituserAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a blog post"
    argument :log, String, "Header for the post", required: true
    argument :name, String, "Full body of the post", required: true
  end
end