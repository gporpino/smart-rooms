source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'cancan'
gem 'will_paginate', '~> 3.0'
gem 'ransack'
gem 'faker'
gem 'bootstrap-datetimepicker-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'chosen-rails'

# Use debugger
gem 'debugger', group: [:development, :test]

gem 'capistrano', '~> 2.15'

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem "factory_girl_rails"
end

# Use postgresql as the database for Active Record
group :development do
  gem 'pg'
end

group :production do
  gem 'mysql2' # If using mysql in development, this can be outside the production group.
  gem 'therubyracer'
end
