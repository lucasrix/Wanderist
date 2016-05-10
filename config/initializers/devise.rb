Devise.setup do |config|
  config.password_length = 6..128
  config.mailer_sender = 'notification@maplifyapp.com'
end
