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
options = { :via_options           => {
              :address              => "smtp.gmail.com",
              :port                 => 587,
              :user_name            => 'heynsd@gmail.com',
              :password             => 'password',
              :authentication       => 'plain',
              :enable_starttls_auto => true
              },
            :via                  => :smtp }

mailer = Mailer.new(options)

# This is a Hash that will be passed to the awesome_email method
details = { to: 'deon@deonheyns.com',
            from: 'heynsd@gmail.com',
            subject: 'Welcome to awesome!',
            template_path: 'views/contact.html.erb' }


mailer.contact_email(details)