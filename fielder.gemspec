# frozen_string_literal: true

require_relative "lib/fielder/version"

Gem::Specification.new do |spec|
  spec.name          = "fielder"
  spec.version       = Fielder::VERSION
  spec.authors       = ["Dorji Khandu"]
  spec.email         = ["dorji.khandu@selise.ch"]

  spec.summary       = <<~DESC
    "Gem to store and customize the query fields configurations for Client,
     works only with ActiveRecords"
  DESC

  spec.homepage = "https://telecom.selise.ch/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://gems.selise.tech"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.org/selise07/fielder"
  spec.metadata["changelog_uri"] = "https://github.org/selise07/fielder/src/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency "activerecord"
  spec.add_dependency "scenic"

  spec.add_development_dependency "debug"
  spec.add_development_dependency "generator_spec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails"
end
