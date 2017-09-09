require 'erb'
require 'pony'

class Mailer
  # Pony Options
  OPTIONS = {
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

  def initialize
   Pony.options = OPTIONS
  end

  def contact_form_email(details)
    @to           = details[:to] || ENV["SENDGRID_TO"] || "hello@icfmoldova.com"
    @from         = details[:from]
    @name         = details[:name]
    @message      = details[:message] || "No message was sent."
    @ip           = details[:ip] || "Unknown"
    @subject      = details[:subject] || "Website Contact Form: #{@name} (#{@from})"
    template_path = "views/contact.html.erb"
    
    # Using instance variables inside the text message
    context = binding
    body = ERB.new(File.read(template_path)).result(context)

    Pony.mail(:to => @to, :from => @from, :subject => @subject, :html_body => body)
  end
end

# mailer = Mailer.new()
# mailer.sendmail(details)