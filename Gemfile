source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
gem 'pg'

gem 'bootstrap-sass', '~> 3.3.7'

gem 'font-awesome-rails'

gem 'devise'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'jwt'
gem 'kaminari'
gem 'active_model_serializers', '~> 0.10.0'
gem 'pg_search'
gem "paperclip", "~> 5.0.0"
gem 'simple_form'
gem 'active_link_to'
gem 'sidekiq'
gem 'fog'
gem 'rack-cors', :require => 'rack/cors'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'faker', '~> 1.7.2'
  gem 'factory_girl_rails'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'rspec-rails', '~> 3.5'
  gem 'database_cleaner'
  gem 'webmock'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'capybara'
  gem 'annotate'
  gem 'pry-rails'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
