# This is a fix to make request.ip return the correct source IP address on Google Cloud Run.
# Rack already includes some logic to filter out known "trusted proxy" addresses, but this does not
# match the proxy used in front of GCR instances. This "patch" fixes that logic to also filter out
# link local IPv4 addresses (which the Google proxy uses).
# Please note: If you deploy this somewhere where you actually might get direct requests from link
# local addresses, this will lead to wrong source IP addresses and you might want to disable this
# initializer in these situations.

def link_local?(ip)
  IPAddr.new(ip).link_local?
rescue IPAddr::Error
  false
end

original_filter = Rack::Request.ip_filter
Rack::Request.ip_filter = lambda { |ip| link_local?(ip) || original_filter.call(ip) }
