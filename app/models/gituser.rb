class Gituser < ApplicationRecord
  has_many :gitreps, dependent: :destroy
end
