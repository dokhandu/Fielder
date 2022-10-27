# frozen_string_literal: true

require "active_record/migration"

class FielderSpecMigrator
  # Truncates all the AR records - NOTE ~> Will only work for SQlite
  # TODO: For PG adapter use `conn.execute("TRUNCATE #{table}")` in line 23
  def clean
    conn = ActiveRecord::Base.connection
    tables = conn.tables
    tables.delete "schema_migrations"
    tables.each { |table| conn.execute("Delete from #{table}") }
  end
end
