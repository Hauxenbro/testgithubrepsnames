# frozen_string_literal: true

class Gitrep < ApplicationRecord
  belongs_to :gituser
  validates :gituser_id, presence: true
  validates :name, presence: true
end
