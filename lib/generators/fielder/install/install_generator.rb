# frozen_string_literal: true

require_relative "../generator_helper"
require "rails/generators"
require "rails/generators/active_record"

module Generators
  module Fielder
    module Install
      # Install Fielder inside Rails Application
      class InstallGenerator < ::Rails::Generators::Base
        include ::Rails::Generators::Migration
        include GeneratorHelper

        source_root File.expand_path("templates", __dir__)


        MODELS = %w[create_prime_model create_field_model create_field_setting].freeze

        def self.next_migration_number(dirname)
          ::ActiveRecord::Generators::Base.next_migration_number(dirname)
        end

        def create_migration_files
          MODELS.each { |model| create_migration_file(model) }
        end
      end
    end
  end
end

