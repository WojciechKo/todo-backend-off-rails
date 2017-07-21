require 'rack'
Bundler.require :default, ENV['RACK_ENV']

require_relative '../app/api'

Application = Rack::Builder.new do
  use Rack::Reloader

  map '/' do
    run ->(_env) { [200, {}, ['Server is working'.to_json]] }
  end

  map '/api' do
    run API.app
  end
end.to_app
