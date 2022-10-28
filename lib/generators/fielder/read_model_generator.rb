# frozen_string_literal: true

require_relative "generator_helper"
require "rails/generators"
require "rails/generators/active_record"
require "scenic"

module Fielder
  # Install Fielder read model inside Rails Application
  class ReadModelGenerator < ::Rails::Generators::Base
    include GeneratorHelper

    source_root File.expand_path("templates", __dir__)

    def invoke_model_creation
      create_model_class(table_name.singularize.to_s)
    end

    def invoke_view_generator
      invoke "scenic:view", [table_name], mat_options
    end

    private

    # The reads will be configured with materialized views
    def mat_options
      { "skip_namespace" => false, "skip_collision_check" => false, "materialized" => true, "no_data" => false }
    end

    def table_name
      "prime_model_lists"
    end
  end
end
