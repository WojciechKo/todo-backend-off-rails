require 'bundler'

ENV.update('RACK_ENV' => 'development') if ENV['RACK_ENV'].nil?
Bundler.require :default, ENV.fetch('RACK_ENV')
Dotenv.load(".env.#{ENV.fetch('RACK_ENV')}", '.env')

$LOAD_PATH.unshift(File.expand_path('lib'))
$LOAD_PATH.unshift(File.expand_path('app'))

Dir.mkdir('log') unless Dir.exist?('log')
