DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

Sequel.extension :migration

unless Sequel::Migrator.is_current?(DB, 'db/migrations')
  require 'database_utils'
  DatabaseUtils.migrate
end
