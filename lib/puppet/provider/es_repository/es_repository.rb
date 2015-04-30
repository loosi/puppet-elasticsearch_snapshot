#
#
#
Puppet::Type.type(:es_repository).provide(:es_repository) do
  require File.join(File.dirname(__FILE__).split('/')[0..-2],'lib','rest.rb')
  require 'uri'

  commands mkdir: 'mkdir'

  def exists?
    rest = Rest.new
    #ep = URI(resource[:keystone_endpoint])
    #@property_hash[:nova] = OpenStackAPI.new(ep.host,ep.port,ep.path,resource[:username],resource[:password],resource[:tenant])
    puts rest.get("http://#{resource[:ip]}:#{resource[:port]}/_snapshot")
    true
  end

  def create

  end

  def destroy
    notice("Deleting of repo is not implemented.")
  end



end
