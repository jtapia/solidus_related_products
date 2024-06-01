# frozen_string_literal: true

module SolidusRelatedProducts
  module Admin
    module ProductsController
      def related
        load_resource
        @relation_types = ::Spree::Product.relation_types
      end

      ::Spree::Admin::ProductsController.prepend(self)
    end
  end
end
