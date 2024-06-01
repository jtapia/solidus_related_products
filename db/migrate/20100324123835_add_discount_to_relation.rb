# frozen_string_literal: true

class AddDiscountToRelation < ActiveRecord::Migration[6.1]
  def change
    add_column :relations, :discount_amount, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
