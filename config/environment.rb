# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
StoreEngine::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "hola@menthora.com",
  :password => "Lobo2020",
  :domain => "http://menthora.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}