source 'https://rubygems.org'
# https://devcenter.heroku.com/articles/ruby-support#supported-runtimes
# MRI: 2.2.9, 2.3.6, 2.4.3, 2.5.0
ruby "2.4.3"

# Likely be the last bug fix release for Rails 4.2
gem 'rails', '4.2.10'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'


# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Spring speeds up development by keeping your application running in the background. 
# Read more: https://github.com/rails/spring
gem 'spring', group: :development

# Use bootstrap as front-end framework for developing responsive, mobile first projects on 
# the web.
gem 'bootstrap-sass', '~> 3.1.1'

# Use paperclip as an easy file attachment management for ActiveRecord
# Workaround => Using paperclip 4.1.1 from git://github.com/thoughtbot/paperclip.git 
# (at master).
gem 'paperclip', github: 'thoughtbot/paperclip'

# Extend paperclip with Dropbox storage.
gem 'paperclip-dropbox', '>= 1.1.7'

# Protect our account date using Figaro.
gem 'figaro', '>= 1.0'

gem 'devise'

# Using `source` more than once without a block is a security risk, 
# and may result in installing unexpected gems. To resolve this warning, 
# use a block to indicate which gems should come from the secondary source.
# Stripe gem for accepting credit card
source 'https://code.stripe.com' do
  gem 'stripe'
end

# Use PostgreSQL as the database for Active Record in the production.
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Use SQLite3 as the database for Active Record in the development and test environments.
group :development, :test do
  gem 'sqlite3'
end
