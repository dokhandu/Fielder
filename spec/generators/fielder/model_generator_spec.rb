# frozen_string_literal: true

require "spec_helper"
require "generator_spec/test_case"
require "generators/fielder/model_generator"

RSpec.describe ::Fielder::ModelGenerator, type: :generator do # rubocop:disable Metrics/BlockLength
  include GeneratorSpec::TestCase
  destination File.expand_path("tmp", __dir__)

  # cleanup the tmp directory
  after { prepare_destination }

  describe "no options" do # rubocop:disable Metrics/BlockLength
    before do
      prepare_destination
      run_generator
    end

    it "tests creation of a AR inherited class of 'prime_model' " do
      expect(destination_root).to(
        have_structure do
          directory("app") do
            directory("models") do
              file("prime_model.rb") do
                contains("class PrimeModel < ActiveRecord::Base")
                contains "belongs_to :modelable, polymorphic: true"
                contains "has_many :field_models, dependent: :destroy"
                contains "accepts_nested_attributes_for :field_models, allow_destroy: true"
              end
            end
          end
        end
      )
    end

    it "tests creation of a AR inherited class of 'field_model' " do
      expect(destination_root).to(
        have_structure do
          directory("app") do
            directory("models") do
              file("field_model.rb") do
                contains("class FieldModel < ActiveRecord::Base")
                contains "belongs_to :prime_model"
                contains "has_many :field_settings, dependent: :destroy"
                contains "accepts_nested_attributes_for :field_settings, allow_destroy: true"
              end
            end
          end
        end
      )
    end

    it "tests creation of a AR inherited class of 'field_setting' " do
      expect(destination_root).to(
        have_structure do
          directory("app") do
            directory("models") do
              file("field_setting.rb") do
                contains("class FieldSetting < ActiveRecord::Base")
                contains "belongs_to :field_model"
              end
            end
          end
        end
      )
    end
  end

  describe "--enable-read option" do # rubocop:disable Metrics/BlockLength
    before do
      prepare_destination
      run_generator %w[--read-model]
    end

    it "tests creation of read model class of 'prime_model_lists' " do
      expect(destination_root).to(
        have_structure do
          directory("app") do
            directory("models") do
              file("prime_model_list.rb") do
                contains("class PrimeModelList < ActiveRecord::Base")
                contains("self.primary_key = :setting_id")
                contains "def self.refresh"
                contains "Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)"
                contains "end"
                contains "def readonly?"
                contains "true"
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
