# frozen_string_literal: true

ENV["RACK_ENV"] ||= "development"

$stdout.sync = true

require "bundler/setup"
require "dotenv"

Bundler.require :default
Bundler.require Sinatra::Base.environment

root_path = File.expand_path(File.join(File.dirname(__FILE__), "../app"))
set :root, root_path
set :app_file, "#{root_path}/main.rb"
set :erb, escape_html: true

# Sadly, the environment-specific override logic is in dotenv-rails, not dotenv
# core, so we have to do this ourself (non-existing files are ignored):
Dotenv.load(
  File.expand_path("../.env.#{settings.environment}.local", __dir__),
  File.expand_path("../.env.local", __dir__),
  File.expand_path("../.env.#{settings.environment}", __dir__),
  File.expand_path("../.env", __dir__)
)

require_all "config/initializers"

require_all "app"
