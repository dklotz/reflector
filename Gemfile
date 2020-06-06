# frozen_string_literal: true

ruby IO.read(".ruby-version").strip
source "https://rubygems.org"

gem "dotenv"
gem "erubi"
gem "puma"
gem "rake"
gem "require_all"
gem "sinatra"
gem "sinatra-contrib"

# Testing
group :test do
  gem "rack-test"
  gem "rspec"
end

# Debugging
group :development, :test do
  gem "pry"
  gem "pry-byebug"
  gem "pry-doc"
  gem "rufo"
  gem "rubocop"
  gem "rubocop-performance"
end

group :development do
  gem "awesome_print"
  gem "foreman"
  gem "pre-commit", require: false
end
