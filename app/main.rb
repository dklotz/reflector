# frozen_string_literal: true

require "sinatra"
require "sinatra/json"
require "sinatra/reloader" if development?
require "resolv"

set :protection, except: [:json_csrf]

get "/" do
  ip = request.ip
  info = {
    ip: ip,
    host: resolve(ip),
    v6: IPAddr.new(ip).ipv6?,
    user_agent: request.user_agent,
    headers: extract_headers,
  }
  json info
end

# Tries to resolve IP to hostname, returns nil on resolve errors.
def resolve(ip)
  Resolv.getname(ip)
rescue Resolv::ResolvError
  nil
end

# Rack mangles headers, so e.g. 'Accept-Charset' becomes 'HTTP_ACCEPT_CHARSET'.
# This method reverses that transformation.
def extract_headers
  request.env.
    select { |k, _| k.start_with? "HTTP_" }.
    transform_keys { |k| k.sub(/^HTTP_/, "").split("_").map(&:capitalize).join("-") }
end
