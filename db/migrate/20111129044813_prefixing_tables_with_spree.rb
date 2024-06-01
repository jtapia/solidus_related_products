# frozen_string_literal: true

class PrefixingTablesWithSpree < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    rename_table :relation_types, :spree_relation_types
    rename_table :relations, :spree_relations
  end
end
