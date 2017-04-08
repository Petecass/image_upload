ENV['RACK_ENV'] = 'test'
# Load the Sinatra app
require File.join(File.dirname(__FILE__), '..', 'server')

require 'rspec'
require 'rack/test'
require 'factory_girl'
require 'shoulda-matchers'
require 'faker'
require 'database_cleaner'

Dir[File.dirname(__FILE__) + '/factories/*.rb'].each { |file| require file }
set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include FactoryGirl::Syntax::Methods

  conf.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  conf.before(:each) do
    DatabaseCleaner.start
  end

  conf.after(:each) do
    DatabaseCleaner.clean
  end
end

def app
  App
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
  end
end
