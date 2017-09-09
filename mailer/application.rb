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

get "/mailer" do
  "Mail server is working properly."
end

post '/mailer/conact' do
  content_type :json

  form_data = {
    from: params[:from],
    name: params[:name],
    message: params[:message],
    ip: request.ip
  }

  mailer = Mailer.new()
  mailer.contact_form_email(form_data)

  {
    success: "Thank you, we'll get in touch with you!",
    status: 200
  }.to_json
end