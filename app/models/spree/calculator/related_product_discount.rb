# frozen_string_literal: true

module Spree
  class Calculator::RelatedProductDiscount < Spree::Calculator
    def self.description
      I18n.t('spree.related_product_discount')
    end

    def compute(object)
      if object.is_a?(Array)
        return if object.empty?

        order = object.first.order
      else
        order = object
      end

      return unless eligible?(order)

      total = order.line_items.inject(0) do |sum, line_item|
        relations = Spree::Relation.where(*discount_query(line_item))
        discount_applies_to = relations.map { |rel| rel.related_to.variant }

        order.line_items.each do |li|
          next li unless discount_applies_to.include? li.variant

          discount = relations.detect { |rel| rel.related_to.variant == li.variant }.discount_amount
          sum += if li.quantity < line_item.quantity
                   (discount * li.quantity)
                 else
                   (discount * line_item.quantity)
                 end
        end

        sum
      end

      total
    end

    def eligible?(order)
      order.line_items.any? do |line_item|
        Spree::Relation.exists?(discount_query(line_item))
      end
    end

    def discount_query(line_item)
      [
        'discount_amount <> 0.0 AND ((relatable_type = ? AND relatable_id = ?) OR (relatable_type = ? AND relatable_id = ?))',
        'Spree::Product',
        line_item.variant.product.id,
        'Spree::Variant',
        line_item.variant.id
      ]
    end
  end
end
