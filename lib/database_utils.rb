require 'pg'
require 'sequel'
require 'fileutils'

class DatabaseUtils
  MIGRATION_TEMPLATE = <<~STR.freeze
    Sequel.migration do
      change do
      end
    end
  STR

  class << self
    def setup
      with_postgres do |conn|
        conn.exec("CREATE DATABASE #{database_name}")
      end

      migrate
    end

    def migrate(version = nil)
      Sequel.extension :migration

      migration_options = { use_transactions: true }

      if version
        migration_options[:target] = version.to_i
        puts "Migrating to version #{version}"
      else
        puts 'Migrating to the latest'
      end

      Sequel.connect(ENV.fetch('DATABASE_URL')) do |conn|
        Sequel::Migrator.run(conn, migrations_dir, migration_options)
      end

      return unless ENV.fetch('RACK_ENV') == 'development'
      database_schema = `pg_dump --no-owner --schema-only #{database_name}`
      File.write(schema_file, database_schema)
    end

    def drop
      with_postgres do |conn|
        conn.exec("DROP DATABASE #{database_name};")
      rescue PG::InvalidCatalogName => e
        puts e.message
      end
    end

    def create_migration(name)
      raise('Missing migration file name') if name.nil?

      next_migration = last_migration + 1
      filename = "#{format('%03d', next_migration)}_#{name}.rb"
      File.write(File.join(migrations_dir, filename), MIGRATION_TEMPLATE)

      puts "Generated: #{filename}"
    end

    private

    def with_postgres
      conn = PG.connect(ENV.fetch('DATABASE_URL'), dbname: 'postgres')
      yield conn
    ensure
      conn.close
    end

    def last_migration
      *_migrations, last_migration_file = Dir.entries(migrations_dir).last
      /.*(?<last_migration>\d+)_[\w_]+.rb/ =~ last_migration_file
      last_migration.to_i
    end

    def migrations_dir
      @migrations_dir ||= File.join(db_path, 'migrations').tap { |path| FileUtils.mkdir_p(path) }
    end

    def schema_file
      @schema_file ||= File.join(db_path, 'schema.sql')
    end

    def db_path
      @db_path ||= 'db'.tap { |path| FileUtils.mkdir_p(path) }
    end

    def database_name
      @database_name ||= ENV.fetch('DATABASE_URL').rpartition('/').last
    end
  end
end
