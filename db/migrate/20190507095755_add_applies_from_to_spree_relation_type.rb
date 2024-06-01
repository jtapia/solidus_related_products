# frozen_string_literal: true

class AddAppliesFromToSpreeRelationType < SolidusSupport::Migration[4.2]
  def change
    add_column :spree_relation_types, :applies_from, :string

    reversible do |change|
      change.up do
        Spree::RelationType.update_all(applies_from: 'Spree::Product')
      end
    end
  end
end
