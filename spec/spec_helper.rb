ENV['RACK_ENV'] = 'test'
# Load the Sinatra app
require File.join(File.dirname(__FILE__), '..', 'server')

require 'rspec'
require 'rack/test'
require 'factory_girl'
require 'shoulda-matchers'
require 'faker'
require 'database_cleaner'
require 'pry'

Dir[File.dirname(__FILE__) + '/factories/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }
set :environment, :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods
  config.include Request::JsonHelpers, type: :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
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
    with.library :active_model
  end
end
