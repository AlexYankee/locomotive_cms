# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Cms::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['MANDRILL_USERNAME'],
  :password => ENV['MANDRILL_PASSWORD'],
  :domain => ENV['MANDRILL_DOMAIN'],
  :address => 'smtp.mandrillapp.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
