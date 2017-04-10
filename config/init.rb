require 'sinatra/activerecord'
require 'pg'

RACK_ENV ||= ENV['RACK_ENV'] || 'development'

# Allows more characters to be uploaded to server through api
Rack::Utils.key_space_limit = 68_719_476_736

unless RACK_ENV == 'production'
  require 'dotenv'
  Dotenv.load
end

Dir[File.join(File.dirname(__FILE__), '*.rb')].each { |f| require f }
