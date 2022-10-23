# frozen_string_literal: true

require "spec_helper"
require "generator_spec/test_case"
require "generators/fielder/install/install_generator"

RSpec.describe ::Generators::Fielder::Install::InstallGenerator, type: :generator do # rubocop:disable Metrics/BlockLength
  include GeneratorSpec::TestCase
  destination File.expand_path("tmp", __dir__)

  # cleanup the tmp directory
  after { prepare_destination }

  describe "no options" do # rubocop:disable Metrics/BlockLength
    before do
      prepare_destination
      run_generator
    end

    expected_parent_class = lambda {
      parent = "ActiveRecord::Migration"
      version = ActiveRecord::VERSION
      format("%s[%d.%d]", parent, version::MAJOR, version::MINOR)
    }.call

    it "tests a migration file for creating the 'prime_model' table" do
      expect(destination_root).to(
        have_structure do
          directory("db") do
            directory("migrate") do
              migration("create_prime_model") do
                contains("class CreatePrimeModel < #{expected_parent_class}")
                contains "def change"
                contains "create_table :prime_models do |t|"
                contains "t.references :modelable, polymorphic: true, index: true"
                contains "t.string :name"
                contains "t.string :code"
              end
            end
          end
        end
      )
    end

    it "tests a migration file for creating the 'field_model' table" do
      expect(destination_root).to(
        have_structure do
          directory("db") do
            directory("migrate") do
              migration("create_field_model") do
                contains("class CreateFieldModel < #{expected_parent_class}")
                contains "def change"
                contains "create_table :field_models do |t|"
                contains "t.references :prime_model, null: false, foreign_key: true"
                contains "t.string :name"
                contains "t.string :code"
              end
            end
          end
        end
      )
    end

    it "tests a migration file for creating the 'field_setting' table" do
      expect(destination_root).to(
        have_structure do
          directory("db") do
            directory("migrate") do
              migration("create_field_setting") do
                contains("class CreateFieldSetting < #{expected_parent_class}")
                contains "def change"
                contains "create_table :field_settings do |t|"
                contains "t.references :field_model, null: false, foreign_key: true"
                contains "t.string :name"
                contains "t.string :code"
                contains "t.integer :rank"
                contains "t.boolean :display, null: false, default: true"
              end
            end
          end
        end
      )
    end
  end
end
