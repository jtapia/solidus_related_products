# frozen_string_literal: true

class CreateRelationTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :relation_types do |t|
      t.string :name
      t.text :description
      t.string :applies_to
      t.timestamps
    end
  end
end
