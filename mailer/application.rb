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
whitelist = ENV['WHITELIST'].split

set :protection, :origin_whitelist => whitelist



get "/" do
  content_type :json

  { works: true }.to_json
end

post '/contact' do
  email = ""

  params.each do |value|
    email += "#{value[0]}: #{value[1]}\n"
  end

  Pony.mail(
    :to => ENV['email_recipients'],
    :from => 'noreply@example.com',
    :subject => 'New Contact Form',
    :body => email
  )

  { "email": email }.to_json
end