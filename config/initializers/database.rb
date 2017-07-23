DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

begin
  Sequel.extension :migration
  Sequel::Migrator.check_current(DB, 'db/migrations')
rescue Sequel::Migrator::NotCurrentError
  require 'database_utils'
  DatabaseUtils.migrate
end
