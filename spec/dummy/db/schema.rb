# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_024_062_953) do
  create_table "field_models", force: :cascade do |t|
    t.integer "prime_model_id", null: false
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prime_model_id"], name: "index_field_models_on_prime_model_id"
  end

  create_table "field_settings", force: :cascade do |t|
    t.integer "field_model_id", null: false
    t.string "name"
    t.string "code"
    t.integer "rank"
    t.boolean "display", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_model_id"], name: "index_field_settings_on_field_model_id"
  end

  create_table "prime_models", force: :cascade do |t|
    t.string "modelable_type"
    t.integer "modelable_id"
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index %w[modelable_type modelable_id], name: "index_prime_models_on_modelable"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "field_models", "prime_models"
  add_foreign_key "field_settings", "field_models"
end
