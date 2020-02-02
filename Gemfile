# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.2.1'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'#, '1.4.2'
# gem 'sqlite3', git: 'https://github.com/larskanis/sqlite3-ruby', branch: 'add-gemspec'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'

# Use Puma as the app server
gem 'puma', '4.3.1'

# Use SCSS for stylesheets
gem 'sass-rails', '6.0.0'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '4.2.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '5.2.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.9.1'

# Use Active Model has_secure_password
gem 'bcrypt', '3.1.13'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.4.5', require: false

gem 'font-awesome-rails', '4.7.0.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and
  # get a debugger console
  gem 'byebug', '11.1.0', platforms: %i[mri mingw x64_mingw]

  # Test data generators
  gem 'factory_bot_rails', '5.1.1'

  # gives us access to assigns, so we can test @variables
  gem 'rails-controller-testing', '1.0.4'

  gem 'rspec-collection_matchers', '1.2.0' # better matcher syntax for specs
  gem 'rspec-rails', '4.0.0.beta4'

  gem 'simplecov', '0.17.1'

  # Formatting and linting
  gem 'rubocop', '0.79.0'
  gem 'rubocop-rspec', '1.37.1'

  gem 'guard-rspec', '4.7.3', require: false

  gem 'htmlbeautifier', '1.3.1'

  gem 'faker', '2.10.1'
end

group :development do
  # Access an interactive console on exception pages or by calling
  # 'console' anywhere in the code.
  gem 'listen', '3.1.5'
  gem 'web-console', '4.0.1'
  gem 'tzinfo-data'
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '3.30.0'
  gem 'selenium-webdriver', '3.142.7'

  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '4.2.0'

  gem 'database_cleaner', '1.7.0'
end
