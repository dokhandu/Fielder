# frozen_string_literal: true

require_relative "fielder/version"
require_relative "fielder/configuration"

# nodoc
module Fielder
  class Error < StandardError; end

  class << self
    # Acts as reader for Fielder's Global Configuration
    def configuration
      @configuration ||= Fielder::Configuration.instance
    end

    def configure
      @configure ||= configuration
      yield(configuration) if block_given?
      @configure
    end

    def enabled_read?
      configuration.enable_read_model
    end
  end
end
