# frozen_string_literal: true

class AddBidirectionalToSpreeRelationType < SolidusSupport::Migration[5.2]
  def change
    add_column :spree_relation_types, :bidirectional, :boolean, default: false
  end
end
