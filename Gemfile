source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '>= 4.3.8'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Pagination
gem 'kaminari'

# Jquery
gem 'jquery-rails'

# Bootstrap
gem "bootstrap-sass"
gem 'bootstrap'

# I18n
gem 'rails-i18n'
#gem 'i18n-tasks', '~> 0.9.21'
gem 'i18n-tasks'

# DEVISE
gem 'devise'

gem "autoprefixer-rails"

# OPENWEATHER
#gem 'openweathermap', '~> 0.2.3'

# PRAWN
#gem 'prawn'

# PDF
gem 'wicked_pdf'  
gem 'wkhtmltopdf-binary' 
#wicked_pdf is a wrapper for wkhtmltopdf, you'll need to install that, too



group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  #gem 'capybara', '>= 2.15'
  gem 'capybara'
  gem 'selenium-webdriver'

  gem 'hirb', '~> 0.7.3'

  # RSPEC
  gem 'rspec-rails', '~> 3.7'

  # FAKER
  #gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'

  # FACTORY BOT
  gem 'factory_bot_rails'

  # Graph de DB
  gem 'railroady'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  #gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'listen', '~> 3.7', '>= 3.7.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem "better_errors"
  gem "binding_of_caller"
  

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
