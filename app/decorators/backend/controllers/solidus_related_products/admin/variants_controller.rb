# frozen_string_literal: true

module SolidusRelatedProducts
  module Admin
    module VariantsController
      def self.prepended(base)
        base.before_action :load_relation_types, only: [:edit, :update]
      end

      private

      def load_relation_types
        @relation_types = ::Spree::Variant.relation_types
      end

      ::Spree::Admin::VariantsController.prepend(self)
    end
  end
end
