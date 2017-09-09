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

  def initialize(options)
   Pony.options = options
  end

  def contact_form_email(details)
    @to           = details[:to] || ENV["SENDGRID_TO"] || "hello@icfmoldova.com"
    @from         = details[:from]
    @messsage     = details[:message] || "No message was sent."
    subject       = details[:subject] || "Welcome to this awesome email!"
    template_path = "views/contact.html.erb"
    
    # Using instance variables inside the text message
    context = binding
    body = ERB.new(File.read(template_path)).result(context)

    Pony.mail(:to => @to, :from => @from, :subject => subject, :html_body => body)
  end
end



mailer = Mailer.new(options)

# This is a Hash that will be passed to the awesome_email method
details = { to: '',
            from: 'hello@icfmoldova.com',
            subject: '',
            template_path: '' }


mailer.sendmail(details)