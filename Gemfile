source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'execjs'
gem 'therubyracer'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'bcrypt-ruby', '~> 3.0.0'

group :development, :test do
      
      gem 'rspec-rails', '~> 2.0'
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
   gem 'pg'
   gem 'rails_stdout_logging' 
end
 
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'httparty'
gem "rails-settings-cached", "0.2.4"


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.

group :test do
      gem 'webmock'
      gem 'factory_girl_rails'
      gem 'capybara'
      gem 'launchy'
      gem 'simplecov', :require => false
end
# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
gem 'debugger', :group => :development

