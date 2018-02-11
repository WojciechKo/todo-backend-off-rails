require 'rspec/core/rake_task'
require_relative 'config/environment'
require 'database_utils'

RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

task travis: %i[spec rubocop]

task :console do
  at_exit do
    run_command 'bundle exec pry -r ./config/application.rb'
  end
end

task :rubocop do
  run_command 'bundle exec rubocop'
end

namespace :db do
  task :setup do
    DatabaseUtils.setup
  end

  task :migration, [:name] do |_task, args|
    DatabaseUtils.create_migration(args[:name])
  end

  task :migrate, [:version] do |_task, args|
    DatabaseUtils.migrate(args[:version])
  end

  task :drop do
    DatabaseUtils.drop
  end

  task :console do
    run_command "psql -d #{ENV['DATABASE_URL']}"
  end
end

def run_command(command)
  system(command) || abort("\n== Command #{command} failed ==")
end
