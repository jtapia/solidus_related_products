# frozen_string_literal: true

Spree::Backend::Config.configure do |config|
  break if !config.respond_to? :menu_items

  config.menu_items.detect { |menu_item|
    menu_item.label == :products
  }.sections << :relation_types
end

Rails.application.config.to_prepare do
  Spree::Backend::Config.configure do |config|
    config.menu_items = config.menu_items.map do |item|
      if item.label.to_sym == :settings
        # The API of the MenuItem class changes in Solidus 4.2.0
        if item.respond_to?(:children)
          item.children << Spree::BackendConfiguration::MenuItem.new(
            label: :relation_types,
            condition: -> { can?(:admin, Spree::Product) },
            url: -> { Spree::Core::Engine.routes.url_helpers.admin_relation_types_path },
            match_path: /relation_types/
          )
        else
          item.sections << :relation_types
        end
      elsif item.label.to_sym == :products
        if item.respond_to?(:children)
          item.children << Spree::BackendConfiguration::MenuItem.new(
            label: :relation_types,
            condition: -> { can?(:admin, ::Spree::Product) },
            url: -> { Spree::Core::Engine.routes.url_helpers.admin_relation_types_path },
            match_path: /relation_types/
          )
        else
          item.sections << :relation_types
        end
      end
      item
    end
  end
end
