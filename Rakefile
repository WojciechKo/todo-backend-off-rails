require 'rspec/core/rake_task'
require_relative 'config/application'

RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

namespace :db do
  def database_name
    ENV.fetch('DATABASE_URL').rpartition('/').last
  end

  task :setup do
    conn = PG.connect(ENV.fetch('DATABASE_URL'), dbname: 'postgres')
    conn.exec("CREATE DATABASE #{database_name}")
  end

  task :drop do
    conn = PG.connect(ENV.fetch('DATABASE_URL'), dbname: 'postgres')
    conn.exec("DROP DATABASE #{database_name}")
  end
end
