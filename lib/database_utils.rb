require 'pg'
require 'sequel'
require 'fileutils'

class DatabaseUtils
  class << self
    def setup
      conn = PG.connect(ENV.fetch('DATABASE_URL'), dbname: 'postgres')
      conn.exec("CREATE DATABASE #{database_name}")
      migrate
    end

    def migrate(version = nil)
      Sequel.extension :migration

      db = Sequel.connect(ENV.fetch('DATABASE_URL'))
      if version
        puts "Migrating to version #{version}"
        Sequel::Migrator.run(db, migrations_dir, target: version.to_i)
      else
        puts 'Migrating to latest'
        Sequel::Migrator.run(db, migrations_dir)
      end

      return unless ENV.fetch('RACK_ENV') == 'development'
      db.extension :schema_dumper
      database_schema = db.dump_schema_migration(same_db: true)
      File.write(schema_file, database_schema)
    end

    def drop
      conn = PG.connect(ENV.fetch('DATABASE_URL'), dbname: 'postgres')
      command = "DROP DATABASE #{database_name};"
      conn.exec(command)
      File.delete(schema_file) unless ENV.fetch('RACK_ENV') == 'development'
    end

    def create_migration(name)
      abort('Missing migration file name') if name.nil?

      template = <<~STR
        Sequel.migration do
          change do
          end
        end
    STR
      next_migration = last_migration + 1

      filename = "#{format('%03d', next_migration)}_#{name}.rb"
      File.write(File.join(migrations_dir, filename), template)
      puts "Generated: #{filename}"
    end

    private

    def last_migration
      *_migrations, last_migration_file = Dir.entries(migrations_dir).last
      /.*(?<last_migration>\d+)_[\w_]+.rb/ =~ last_migration_file
      last_migration.to_i
    end

    def migrations_dir
      @migrations ||= File.join(db_path, 'migrations').tap { |path| FileUtils.mkdir_p(path) }
    end

    def schema_file
      @schema_file ||= File.join(db_path, 'schema.rb')
    end

    def db_path
      @db_path ||= 'db'.tap { |path| FileUtils.mkdir_p(path) }
    end

    def database_name
      @database_name ||= ENV.fetch('DATABASE_URL').rpartition('/').last
    end
  end
end
