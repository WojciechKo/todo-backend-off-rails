require 'rack'
require_relative '../app/api'

Application = Rack::Builder.new do
  use Rack::Reloader

  map '/' do
    run ->(_env) { [200, {}, ['Server is working']] }
  end

  map '/api' do
    run Api.new
  end
end.to_app
