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
    host: Resolv.getname(ip),
    v6: IPAddr.new(ip).ipv6?,
    user_agent: request.user_agent,
  }
  json info
end
