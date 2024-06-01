# frozen_string_literal: true

class AddDescriptionToSpreeRelations < SolidusSupport::Migration[4.2]
  def change
    add_column :spree_relations, :description, :string
  end
end
