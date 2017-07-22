require 'database_configuration'

RSpec.describe DatabaseConfiguration do
  subject { DatabaseConfiguration.new(database_url) }

  where(:database_url, :database, :user, :password, :host, :port, :database_name) do
    [
      ['postgres://wojciechko:admin1@localhost:9292/todo_mvc', 'postgres', 'wojciechko', 'admin1', 'localhost', '9292', 'todo_mvc']
    ]
  end

  with_them do
    it { is_expected.to have_attributes(database: database, user: user, host: host, port: port, database_name: database_name) }
  end
end
