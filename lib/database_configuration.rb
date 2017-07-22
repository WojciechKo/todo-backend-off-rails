class DatabaseConfiguration
  attr_reader :database_url, :database, :user, :password, :host, :port, :database_name

  def initialize(database_url)
    @database_url = database_url
    /(?<database>.+):\/\/((?<user>[^:.]+)(:(?<password>.+))?@)?(?<host>[^\/^:.]*)(:(?<port>\d*))?\/(?<database_name>.*)/ =~ database_url
    @database = database
    @user = user
    @password = password
    @host = host
    @port = port
    @database_name = database_name
  end
end
