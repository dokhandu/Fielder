# frozen_string_literal: true

class User < ApplicationRecord
  has_many :prime_models, as: :modelable

  accepts_nested_attributes_for :prime_models, allow_destroy: true
end