require 'sinatra/activerecord'
require 'pg'

RACK_ENV ||= ENV['RACK_ENV'] || 'development'

Dir[File.join(File.dirname(__FILE__), '*.rb')].each { |f| require f }
