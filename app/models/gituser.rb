# frozen_string_literal: true

class Gituser < ApplicationRecord
  has_many :gitreps, dependent: :destroy
end
