# frozen_string_literal: true

require_relative "generator_helper"
require "rails/generators"
require "rails/generators/active_record"

module Fielder
  # Generates Fielder's AR class model inside Rails Application
  class ModelGenerator < ::Rails::Generators::Base
    include GeneratorHelper

    class_option :read_model,
                 type: :boolean,
                 required: false,
                 desc: "Generates the database view interface",
                 default: false

    source_root File.expand_path("templates", __dir__)

    MODELS = %w[prime_model field_model field_setting].freeze

    def create_model_classes
      MODELS.each { |model| create_model_class(model) }
    end

    # If the fielder is configured for read_model it invokes read_model generation.
    # However if the users try to generate read_model while the
    # Fielder.configure.enable_read = false the generator will throw error and urge to update the configuration
    def invoke_view_creation
      return unless options[:read_model]

      if check_configurations
        invoke "fielder:read_model"
      else
        ::Kernel.warn "Update your fielder configuration to enable read model"
      end
    end

    private

    def check_configurations
      Fielder.enabled_read?
    end
  end
end
