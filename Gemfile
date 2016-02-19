source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'active_model_serializers'
gem 'puma'

gem 'rack-cors', require: 'rack/cors'
gem 'carrierwave'
gem 'apipie-rails', github: 'Apipie/apipie-rails'

# Auth
gem 'devise_token_auth'
gem 'omniauth-facebook'
gem 'cancancan', '~> 1.10'
gem 'koala', '~> 2.2'

gem 'rack-cors', require: 'rack/cors'
gem 'carrierwave'

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
  gem "capistrano", "~> 3.4"
  gem 'mailcatcher'
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem "rubycritic", require: false
  gem "rails_best_practices"
end

group :test do
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'shoulda-matchers', '~> 3.1'
end

