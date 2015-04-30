#
#
#
Puppet::Type.type(:es_repo).provide(:es_repo) do
  require File.join(File.dirname(__FILE__).split('/')[0..-2],'lib','rest.rb')
  require 'uri'

  # commands mkdir: 'mkdir'

  def exists?
    rest = Rest.new
    rest.get("http://#{resource[:ip]}:#{resource[:port]}/_snapshot").has_key? resource[:name]
  end

  def create
    rest = Rest.new
    req = rest.put("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:name]}", {'type' => resource[:type], 'settings' => resource[:settings] })
    fail "repository creation failed" unless req == {"acknowledged"=>true}
  end

  def destroy
    rest = Rest.new
    req = rest.delete("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:name]}")
    fail "repository creation failed" unless req == {"acknowledged"=>true}
  end



end
