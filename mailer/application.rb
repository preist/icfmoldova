require "rubygems"
require "bundler/setup"
require "sinatra"
require "pony"

require File.join(File.dirname(__FILE__), "environment")

configure do
  set :show_exceptions, :after_handler
end

configure :production, :development do
  enable :logging
end

# whitelist should be a space separated list of URLs
whitelist = ENV['whitelist'].split

set :protection, :origin_whitelist => whitelist

Pony.options = {
  :via => :smtp,
  :via_options => {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => ENV['SENDGRID_DOMAIN'],
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :authentication => :plain,
    :enable_starttls_auto => true
  }
}

get "/" do
  content_type :json

  { works: true }.to_json
end

post '/contact' do
  content_type :json

  { "post": "mail" }.to_json
end