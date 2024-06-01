# frozen_string_literal: true

class CreateRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :relations, force: true do |t|
      t.references :relation_type
      t.references :relatable, polymorphic: true
      t.references :related_to, polymorphic: true
      t.timestamps
    end
  end
end
