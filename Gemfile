source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

# mail
gem 'postmark-rails'

# db
gem 'pg'

# slim templates for mail
gem 'slim-rails'

# serializers
gem 'active_model_serializers'

# tags
gem 'acts-as-taggable-on', '~> 9.0'

# storage and images
gem 'shrine'
gem 'mini_magick'
gem 'image_processing'

# Code style and errors inspection officer, testing
gem "rspec-rails"
gem 'rubocop'
gem 'rubocop-performance'
gem 'rubocop-rspec'
gem 'rubocop-rake'
gem 'rubocop-rails'

# testing

# sign in / sign up
gem "devise"
gem "devise-jwt"
gem "devise-two-factor", github: "cybersecuricy/devise-two-factor", branch: "securicy-fixes-rails-7"

# environment variables
gem "dotenv-rails"

# cors for api
gem "rack-cors"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Swagger
gem "rswag"

# AWS
group :production do
  gem "aws-sdk"
end

# GROver
gem "grover"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'shoulda-matchers', '~> 5.0'
  gem "pry"
  gem 'factory_bot'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

gem "pundit", "~> 2.2"
