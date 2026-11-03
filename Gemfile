source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'rails', '~> 7.2.3', '>= 7.2.3.1'
# Use Puma as the app server
gem 'puma', '~> 7.2', '>= 7.2.1'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 2.0'

group :development, :test do
  gem 'mysql2', '~> 0.5'
  gem 'debug', platforms: %i[mri windows]
  gem 'rspec-rails', '~> 7.1'
  gem 'bundler-audit', require: false
end

group :test do
  gem 'shoulda-matchers', '~> 6.0'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.4'
end

group :production do
  gem 'pg', '~> 1.5'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

gem 'devise', '~> 5.0', '>= 5.0.4'

gem 'active_model_serializers', '~> 0.10.16'

gem 'ransack', '~> 4.2'
gem 'devise_token_auth', '~> 1.3'
gem 'rails-i18n', '~> 7.0'
