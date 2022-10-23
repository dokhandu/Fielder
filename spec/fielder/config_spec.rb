# frozen_string_literal: true

require "spec_helper"

::RSpec.describe Fielder::Configuration do
  describe ".instance" do
    it "returns the singleton instance" do
      expect { described_class.instance }.not_to raise_error
    end
  end

  describe ".new" do
    it "raises NoMethodError" do
      expect { described_class.new }.to raise_error(NoMethodError)
    end
  end

  describe ".enable_read_model" do
    it "configures to enable read model for fielder" do
      expect(described_class.instance.enable_read_model).to be_falsey

      Fielder.configure.enable_read_model = true
      expect(described_class.instance.enable_read_model).to be_truthy
      expect(Fielder.enabled_read?).to be_truthy
    end
  end
end
