# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8', '>= 7.0.8.7'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  gem 'better_errors', '~> 2.10', '>= 2.10.1'
  gem 'binding_of_caller'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug', '~> 3.10', '>= 3.10.1'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'annotate', '~> 3.2'
  gem 'bullet', '~> 7.0', '>= 7.0.7'
  gem 'factory_bot_rails'
  gem 'faker', '~> 3.1', '>= 3.1.1'
  gem 'rspec-rails', '~> 7.0.0'
  gem 'rubocop', '~> 1.58', require: false
  gem 'rubocop-performance', '~> 1.20', require: false
  gem 'rubocop-rails', '~> 2.23', require: false
  gem 'rubocop-rspec'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'capybara-screenshot', '~> 1.0', '>= 1.0.26'
  gem 'database_cleaner', '~> 2.0', '>= 2.0.2', require: false
  gem 'fuubar', '~> 2.5', '>= 2.5.1'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'timecop', '~> 0.9.10', require: false
  gem 'vcr', '~> 6.2', require: false
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'webmock', '~> 3.19'
end

gem 'active_model_serializers', '~> 0.10.13'
gem 'activerecord-session_store', '~> 2.0'
gem 'countries'
gem 'exception_notification', '~> 4.5'
gem 'faraday'
gem 'figaro', '~> 1.2'
gem 'foreman', '~> 0.88.1'
gem 'geocoder', '~> 1.8', '>= 1.8.5'
gem 'net-http'
gem 'timezone', '~> 1.3', '>= 1.3.27'
# dry-rb
gem 'dry-system', '~> 0.23'
gem 'dry-transaction', '~> 0.13'
gem 'dry-validation', '~> 1.7'
