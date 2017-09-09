require "rubygems"
require "bundler/setup"
require "sinatra"

require File.join(File.dirname(__FILE__), "environment")

configure do
  set :show_exceptions, :after_handler
end

configure :production, :development do
  enable :logging
end

helpers do
  # add your helpers here
end

get "/" do
  content_type :json

  { works: true }.to_json
end

post '/mail' do
  content_type :json

  { "post": "mail" }.to_json
end