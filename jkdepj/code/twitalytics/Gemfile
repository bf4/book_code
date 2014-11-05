source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '2.0.1'
gem 'json', '1.6.6'

# START:therubyracer
platform :ruby do
  gem 'therubyracer', '0.9.10'
end
# END:therubyracer

group :test do
  gem 'rspec-rails', '2.8.1'
end

# START:db_driver
group :production do
  # START:pg
  gem 'pg', '0.13.2'
  # END:pg
end

group :development, :test do
  # START:sqlite
  gem 'sqlite3', '1.3.5'
  # END:sqlite
end
# END:db_driver
