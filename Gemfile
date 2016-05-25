source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'active_model_serializers'
gem 'puma'
gem 'haml'
gem 'geokit-rails'
gem 'kaminari'
gem 'browser'
gem "figaro"

# Docs
gem 'apipie-rails', github: 'Apipie/apipie-rails'
gem 'maruku'

# Attachment
gem 'fog'
gem 'fog-aws'
gem 'carrierwave'
gem 'file_validators'
gem 'mini_magick'
gem 'streamio-ffmpeg'

# Auth
gem 'devise_token_auth'
gem 'cancancan', '~> 1.10'
gem 'koala', '~> 2.2'
gem 'has_secure_token'

# Jobs
gem 'delayed_job_active_record'
gem 'houston'
gem 'whenever', :require => false

gem "newrelic_rpm"

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
  gem 'rubocop', require: false
  gem 'analyfy', github: 'RubyGarage/analyfy'

  gem 'rack-cors', require: 'rack/cors'

  #Deploy
  gem 'knife-solo', require: false
  gem 'knife-solo_data_bag', require: false
  gem 'librarian-chef', require: false
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma'
  gem 'capistrano3-delayed-job', '~> 1.0'
end

group :test do
  gem 'simplecov', require: false
  gem 'shoulda-matchers', '~> 3.1'
end

group :production do
  gem 'rails_12factor'
  gem "daemons"
end
