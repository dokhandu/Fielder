# frozen_string_literal: true

require "spec_helper"

RSpec.describe PrimeModel, type: :model do
  describe "#create" do
    context "test data_cleaning"do
      it "creates a prime model" do
        prime_model = PrimeModel.create(name: "Quote", code: "code")
        expect(prime_model).not_to be_nil
      end

      it "creates another prime model" do
        prime_model_a= PrimeModel.create(name: "Quote", code: "code")
        expect(prime_model_a).not_to be_nil
      end
    end
  end
end

