require 'net/http'
require 'uri'
require 'json'
require 'time'
require 'pp'

#puts 'got nova api'

class Rest
  def get(uri,xauth=false)
    uri = URI(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path)
    req['x-auth-token'] = xauth unless xauth == false
    req['content-type'] = 'application/json'
    req['accept'] = 'application/json'
    #puts "URI: #{uri.host} #{uri.port} #{uri.path}"
    res = http.request(req)
    JSON.parse(res.body)
  end
  def put(uri,data,xauth=false)
    uri = URI(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path)
    req.body = data.to_json
    req['x-auth-token'] = xauth unless xauth == false
    req['content-type'] = 'application/json'
    req['accept'] = 'application/json'
    #puts "URI: #{uri.host} #{uri.port} #{uri.path}"
    #puts "DATA: #{data}"
    res = http.request(req)
    JSON.parse(res.body)
  end
  def post(uri,data,xauth=false)
    uri = URI(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path)
    req.body = data.to_json
    req['x-auth-token'] = xauth unless xauth == false
    req['content-type'] = 'application/json'
    req['accept'] = 'application/json'
    #puts "URI: #{uri.host} #{uri.port} #{uri.path}"
    #puts "DATA: #{data}"
    res = http.request(req)
    JSON.parse(res.body)
  end
  def delete(uri,xauth=false)
    uri = URI(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Delete.new(uri.path)
    req['x-auth-token'] = xauth unless xauth == false
    req['content-type'] = 'application/json'
    req['accept'] = 'application/json'
    #puts "URI: #{uri.host} #{uri.port} #{uri.path}"
    res = http.request(req)
    JSON.parse(res.body)
  end
end
