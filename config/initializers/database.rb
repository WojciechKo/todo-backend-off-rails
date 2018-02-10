require_relative 'config'

DB = Sequel.connect(Config.get.database_url)

Sequel.extension :migration

unless Sequel::Migrator.is_current?(DB, 'db/migrations')
  require 'database_utils'
  DatabaseUtils.migrate
end

ROM_CONTAINER = ROM.container(:sql, Config.get.database_url) do |config|
  require 'relations/notes'
  config.register_relation(Notes)
end
