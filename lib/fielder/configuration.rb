# frozen_string_literal: true

require "singleton"

module Fielder
  # Global Configuration for Fielder
  class Configuration
    include Singleton

    attr_accessor :enable_read_model

    def initialize
      @enable_read_model = false
    end
  end
end
