# frozen_string_literal: true

ENV["RACK_ENV"] = "test"

require_relative "../config/environment"
require "rack/test"
require "rspec"

require_all "spec/support"

module RSpecMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec::Matchers.define :be_valid_json do
  match do |actual|
    JSON.parse(actual)
  end
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include RSpecMixin
end
