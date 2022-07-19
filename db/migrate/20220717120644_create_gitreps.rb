# frozen_string_literal: true

# Migration class for Gitreps models
class CreateGitreps < ActiveRecord::Migration[7.0]
  def change
    create_table :gitreps do |t|
      t.string :name
      t.references :gituser, null: false, foreign_key: true

      t.timestamps
    end
  end
end
