# frozen_string_literal: true

require "rubygems"
require "bundler/setup"

# Do not require rspec in production:
if ENV["RACK_ENV"] != "production"
  require "rspec/core/rake_task"

  task default: :test
  task test: :spec

  desc "Run all examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir["spec/**/*_spec.rb"]
  end
end

task :environment do
  require File.join(File.dirname(__FILE__), "config/environment")
end

desc "Start a console with all project dependencies loaded"
task :console do
  ruby "bin/console"
end
