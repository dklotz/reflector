# frozen_string_literal: true

require "logger"

set :logging, ENV["LOG_LEVEL"]&.to_i || Logger::INFO

puts "Configured log level: #{settings.logging}"
