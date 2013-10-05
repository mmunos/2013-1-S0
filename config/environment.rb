# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
S0::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "<span class='field_error'>#{html_tag}</span>".html_safe
end