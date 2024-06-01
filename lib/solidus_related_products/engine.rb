# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusRelatedProducts
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_related_products'

    initializer 'spree.promo.register.promotion.calculators' do |app|
      app.config.spree.calculators.promotion_actions_create_adjustments << "Spree::Calculator::RelatedProductDiscount"
    end

    class << self
      def activate
        ActionView::Base.include RelatedProductsHelper
      end
    end

    config.to_prepare(&method(:activate).to_proc)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
