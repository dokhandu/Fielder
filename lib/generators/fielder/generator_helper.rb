# frozen_string_literal: true

require "rails/generators"
require "rails/generators/active_record"

# nodoc
module GeneratorHelper
  def create_migration_file(template)
    migration_dir = File.expand_path("db/migrate")
    if self.class.migration_exists?(migration_dir, template)
      ::Kernel.warn "Migration already exists: #{template}"
    else
      migration_template(
        "#{template}.rb.erb",
        "db/migrate/#{template}.rb",
        { migration_version: migration_version }
      )
    end
  end

  def create_model_class(template)
    model_dir = File.expand_path("app/models")
    if model_exists?(model_dir, template)
      ::Kernel.warn "Model already exists: #{template}"
    else
      template "#{template}.rb.erb", "app/models/#{template}.rb"
    end
  end

  protected

  def model_exists?(destination_root, template)
    File.exist?(File.join(destination_root, "#{template}.rb"))
  end

  def migration_version
    format(
      "[%d.%d]",
      ActiveRecord::VERSION::MAJOR,
      ActiveRecord::VERSION::MINOR
    )
  end
end
