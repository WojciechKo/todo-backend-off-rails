require 'bundler'

env = ENV.fetch('RACK_ENV', 'development')
Bundler.require :default, env
Dotenv.load(".env.#{env}", '.env')

require_relative '../app/api'

Application = Rack::Builder.new do
  use Rack::Reloader

  map '/' do
    status_server = lambda do |_env|
      [200,
       { 'Content-Type' => 'application/json' },
       ['Server is working'.to_json]]
    end
    run status_server
  end

  map '/api' do
    run API.app
  end
end.to_app
