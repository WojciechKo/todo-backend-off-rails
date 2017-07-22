require 'database_configuration'

RSpec.describe DatabaseConfiguration do
  subject { DatabaseConfiguration.new(database_url) }

  where(:database_url, :database, :user, :password, :host, :port, :database_name) do
    [
      ['postgres://wojciechko:admin1@localhost:9292/todo_mvc', 'postgres', 'wojciechko', 'admin1', 'localhost', '9292', 'todo_mvc'],
      ['postgres://wojciechko@localhost:9292/todo_mvc', 'postgres', 'wojciechko', nil, 'localhost', '9292', 'todo_mvc'],
      ['postgres://localhost:9292/todo_mvc', 'postgres', nil, nil, 'localhost', '9292', 'todo_mvc'],
      ['postgres://wojciechko:admin1@localhost/todo_mvc', 'postgres', 'wojciechko', 'admin1', 'localhost', nil, 'todo_mvc'],
      ['postgres://localhost/todo_mvc', 'postgres', nil, nil, 'localhost', nil, 'todo_mvc'],
      ['postgres://localhost:9292/todo_mvc', 'postgres', nil, nil, 'localhost', '9292', 'todo_mvc']
    ]
  end

  with_them do
    it do
      is_expected.to have_attributes(database_url: database_url, database: database,
                                     user: user, password: password,
                                     host: host, port: port, database_name: database_name)
    end
  end
end
