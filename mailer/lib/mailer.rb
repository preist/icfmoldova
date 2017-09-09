require 'erb'
require 'pony'

class Mailer
  def initialize(options)
   Pony.options = options
  end

  def contact_email(details)
    @to           = details[:to]
    @from         = details[:from]
    subject       = details[:subject]
    template_path = details[:template_path]
    
    # Not doing this will mean your template wont use your instance level variables
    context = binding
    body = ERB.new(File.read(template_path)).result(context)

    Pony.mail(:to => @to, :from => @from, :subject => subject, :html_body => body)
  end
end

# Needed my Mail to send our email
options = {
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

mailer = Mailer.new(options)

# This is a Hash that will be passed to the awesome_email method
details = { to: 'hello@icfmoldova.com',
            from: 'hello@icfmoldova.com',
            subject: 'Welcome to this awesome email!',
            template_path: 'views/contact.html.erb' }


mailer.contact_email(details)