
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require_relative 'config/init'
require './routes/app.rb'

# current_dir = Dir.pwd
# Dir["#{current_dir}/models/*.rb"].each { |file| require file }
#
# before do
#   content_type 'application/json'
# end
#
# get '/' do
#   'Hello World'
# end
