# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
S0::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "<span class='field_error'>#{html_tag}</span>".html_safe
end

Paperclip.options[:command_path] = "/usr/local/bin/"

ActionMailer::Base.smtp_settings = {
 :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => 'showganizer@gmail.com',
  :password             => 'showganizer-www',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }