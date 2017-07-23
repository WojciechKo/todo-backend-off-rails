require 'rspec/core/rake_task'
require_relative 'config/application'

RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

require 'fileutils'

task :console do
  at_exit do
    command = 'bundle exec pry -r ./config/application.rb'
    system(*command) || abort("\n== Command #{command} failed ==")
  end
end

namespace :db do
  task :setup do
    conn = PG.connect(ENV.fetch('DATABASE_URL'), dbname: 'postgres')
    conn.exec("CREATE DATABASE #{database_name}")

    Rake::Task['db:migrate'].invoke
  end

  task :create_migration, [:name] do |_task, args|
    name = args[:name]
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

  def last_migration
    *_migrations, last_migration_file = Dir.entries(migrations_dir).last
    /.*(?<last_migration>\d+)_[\w_]+.rb/ =~ last_migration_file
    last_migration.to_i
  end

  task :migrate, [:version] do |_task, args|
    Sequel.extension :migration

    db = Sequel.connect(ENV.fetch('DATABASE_URL'))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, migrations_dir, target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, migrations_dir)
    end
    db.extension :schema_dumper
    database_schema = db.dump_schema_migration(same_db: true)
    File.write(schema_file, database_schema)
  end

  task :drop do
    conn = PG.connect(ENV.fetch('DATABASE_URL'), dbname: 'postgres')
    conn.exec("DROP DATABASE #{database_name}")
    File.delete(schema_file)
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
