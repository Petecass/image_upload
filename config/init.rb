require 'sinatra/activerecord'
require 'pg'
require 'dotenv'
Dotenv.load

RACK_ENV ||= ENV['RACK_ENV'] || 'development'
Rack::Utils.key_space_limit = 68719476736

Dir[File.join(File.dirname(__FILE__), '*.rb')].each { |f| require f }
