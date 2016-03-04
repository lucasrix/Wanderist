source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'active_model_serializers'
gem 'puma'

gem 'haml'
gem 'geokit-rails'

# Docs
gem 'apipie-rails', github: 'Apipie/apipie-rails'
gem 'maruku'

# Attachment
gem 'carrierwave'
gem 'file_validators'

# Auth
gem 'devise_token_auth'
gem 'omniauth-facebook'
gem 'cancancan', '~> 1.10'
gem 'koala', '~> 2.2'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar'
end

group :development do
  gem 'mailcatcher'
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem "rubycritic", require: false
  gem "rails_best_practices"

  gem 'rack-cors', require: 'rack/cors'
end

group :test do
  gem 'simplecov', require: false
  gem 'shoulda-matchers', '~> 3.1'
end

group :production do
  gem 'rails_12factor'
end