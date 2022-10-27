# frozen_string_literal: true

require_relative "generator_helper"
require "rails/generators"
require "rails/generators/active_record"

module Fielder
  # Generates Fielder's AR class model inside Rails Application
  class ModelGenerator < ::Rails::Generators::Base
    include GeneratorHelper

    source_root File.expand_path("templates", __dir__)

    MODELS = %w[prime_model field_model field_setting].freeze

    def create_model_classes
      MODELS.each { |model| create_model_class(model) }
    end
  end
end
