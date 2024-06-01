# frozen_string_literal: true

require 'spree/preferences/configuration'

module SolidusRelatedProducts
  class Configuration < Spree::Preferences::Configuration
    # Define here the settings for this extension, e.g.:
    #
    # attr_accessor :my_setting
    preference :no_conflict, :boolean, default: false
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
