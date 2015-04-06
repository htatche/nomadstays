source 'https://rubygems.org'

# Determine ruby version, good for heroku and local dev machines
ruby '2.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgresql as the database for Active Record
gem 'pg'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Instead of therubyracer install nodejs on your dev machine
# https://devcenter.heroku.com/articles/rails-asset-pipeline#therubyracer
# gem 'therubyracer'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Authentication
gem 'devise', '~> 3.4.1' 
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'

# Templating
gem 'html2haml'
gem 'haml'
gem 'haml-rails', '~> 0.9'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'font-awesome-sass'

# Sign-on social networks
gem 'bootstrap-social-rails'

# Forms
gem 'simple_form'
gem 'country_select'
gem 'ransack'

# Geolocation
gem 'underscore-rails'
gem 'geocoder'

group :development, :test do

  # Better replacement for IRB console
  gem 'pry-rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-byebug'

  # Imrpoved error-page
  gem 'better_errors'
  gem 'binding_of_caller'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

	# Catch mails in development
	# Start serve with command mailcatcher and open http://localhost:1080
  gem 'mailcatcher'

  # Chrome Rails Panel extension
  gem 'meta_request'

  # Pretty print objects on console
  gem 'awesome_print'

  # Cleaner log
  gem 'quiet_assets'

  # Load environment variables from .env file
  # https://github.com/bkeepers/dotenv
  gem 'dotenv-rails'

  gem 'rspec-rails'
  gem 'factory_girl_rails'

  # https://github.com/bbatsov/rubocop#rails
  gem 'rubocop', require: false
end

group :development do
  gem 'guard-rspec'
  gem 'guard-rubocop'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end

group :production do
  # Heroku needs this
  gem 'rails_12factor'
end
