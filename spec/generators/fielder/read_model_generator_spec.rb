# frozen_string_literal: true

require "spec_helper"
require "generator_spec/test_case"
require "generators/fielder/read_model_generator"

RSpec.describe ::Fielder::ReadModelGenerator, type: :generator do # rubocop:disable Metrics/BlockLength
  include GeneratorSpec::TestCase
  destination File.expand_path("tmp", __dir__)

  # cleanup the tmp directory
  after { prepare_destination }

  describe "no options" do # rubocop:disable Metrics/BlockLength
    before do
      prepare_destination
      run_generator
    end

    it "tests creation of read model class of 'prime_model_lists' " do
      expect(destination_root).to(
        have_structure do
          directory("app") do
            directory("models") do
              file("prime_model_list.rb") do
                contains("class PrimeModelList < ActiveRecord::Base")
                contains "def self.refresh"
                contains "Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)"
              end
            end
          end
        end
      )
    end

    expected_parent_class = lambda {
      parent = "ActiveRecord::Migration"
      version = ActiveRecord::VERSION
      format("%s[%d.%d]", parent, version::MAJOR, version::MINOR)
    }.call

    it "tests creation of a 'prime_model_lists' migration' " do
      expect(destination_root).to(
        have_structure do
          directory("db") do
            directory("migrate") do
              migration("create_prime_model_lists") do
                contains("class CreatePrimeModelLists < #{expected_parent_class}")
                contains "def change"
                contains "create_view :prime_model_lists, materialized: true"
              end
            end
          end
        end
      )
    end
  end
end
