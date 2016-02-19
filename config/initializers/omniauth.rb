Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook,      ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :facebook, '442425175951700', '84b95296f76ecdfbf0c344ca6b14830d'
end