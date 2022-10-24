# frozen_string_literal: true

class FieldModel < ApplicationRecord
  belongs_to :prime_model
  has_many :field_settings, dependent: :destroy

  accepts_nested_attributes_for :field_settings, allow_destroy: true
end
