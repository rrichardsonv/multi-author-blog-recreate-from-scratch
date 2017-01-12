source 'https://rubygems.org'

# PostgreSQL driver for database
gem 'pg'

# Sinatra driver for request handling
gem 'sinatra', '~> 1.0'
gem 'sinatra-contrib'

# Active record yeaaaah
# Arel (simplifies sql queries)
# i18n (Adds support for internationalization ie: ease of translating, room for characters)
gem 'activesupport', '~> 4.2.0'
gem 'activerecord', '~> 4.2.0'
gem 'nokogiri', '~> 1.6.7.1'

# Command line utility
gem 'rake'
# Web server utility
gem 'shotgun'
# Hashing utility for username/password auth
gem 'bcrypt'

group :test do
  #more matchers! onelinerz
  gem 'shoulda-matchers'
  gem 'rack-test'
  gem 'rspec', '~> 3.2'
  #for testing as web users
  gem 'capybara'
end

group :test, :development do
  gem 'factory_girl'
  gem 'faker'
end


