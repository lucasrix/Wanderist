Devise.setup do |config|
  config.password_length = 6..128
  config.mailer_sender = 'notification@maplifyapp.com'
  config.mailer = "CustomDeviseMailer"
  config.reset_password_within = 4.hours
end
