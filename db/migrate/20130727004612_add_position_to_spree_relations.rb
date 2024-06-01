# frozen_string_literal: true

class AddPositionToSpreeRelations < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_relations, :position, :integer
  end
end
