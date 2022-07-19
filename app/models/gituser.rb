# frozen_string_literal: true

class Gituser < ApplicationRecord
  validates :log, presence: true
  validates :name, presence: true
  has_many :gitreps, dependent: :destroy
end
