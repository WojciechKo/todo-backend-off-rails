require 'rspec/core/rake_task'
require_relative 'config/environment'
require 'database_utils'

RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

task :console do
  at_exit do
    command = 'bundle exec pry -r ./config/application.rb'
    system(*command) || abort("\n== Command #{command} failed ==")
  end
end

namespace :db do
  task :setup do
    DatabaseUtils.setup
  end

  task :create_migration, [:name] do |_task, args|
    DatabaseUtils.create_migration(args[:name])
  end

  task :migrate, [:version] do |_task, args|
    DatabaseUtils.migrate(args[:version])
  end

  task :drop do
    DatabaseUtils.drop
  end
end
