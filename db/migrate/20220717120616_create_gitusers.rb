# frozen_string_literal: true

# Migration class for Gitusers model
class CreateGitusers < ActiveRecord::Migration[7.0]
  def change
    create_table :gitusers do |t|
      t.string :log
      t.string :name

      t.timestamps
    end
  end
end
