# frozen_string_literal: true

class AddTestTable < ActiveRecord::Migration[7.0]
  def up # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    create_table :prime_models, force: true do |t|
      t.references :modelable, polymorphic: true, index: true
      t.string :name
      t.string :code

      t.timestamps
    end

    create_table :field_models, force: true do |t|
      t.references :prime_model, null: false, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end

    create_table :field_settings, force: true do |t|
      t.references :field_model, null: false, foreign_key: true
      t.string :name
      t.string :code
      t.integer :rank
      t.boolean :display, null: false, default: true

      t.timestamps
    end

    create_table :users, force: true do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
