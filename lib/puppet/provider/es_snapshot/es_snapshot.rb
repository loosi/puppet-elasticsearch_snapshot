#
#
#
Puppet::Type.type(:es_snapshot).provide(:es_snapshot) do
  require File.join(File.dirname(__FILE__).split('/')[0..-2],'lib','rest.rb')

  def exists?
    rest = Rest.new
    fail "Repo: #{resource[:repo]} does not exists" unless rest.get("http://#{resource[:ip]}:#{resource[:port]}/_snapshot").has_key? resource[:repo]
    snaps = rest.get("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:repo]}/_all")['snapshots']
    result = false
    snaps.each do |s|
        result = true if s['snapshot'] == resource[:snapshot_name]
    end
    result
  end

  def create
    rest = Rest.new
    path_end = resource[:snapshot_name]
    path_end = "#{path_end}?wait_for_completion=true" if resource[:wait_for_completion].to_s == 'true'
    index = resource[:indices].is_a?(Array) ? resource[:indices].join(',') : resource[:indices]
    data = {
      'indices'              => index,
      'partial'              => resource[:partial],
      'ignore_unavailable'   => resource[:ignore_unavailable],
      'include_global_state' => resource[:include_global_state]
    }
    req = rest.put("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:repo]}/#{path_end}", data)
    fail "snapshot creation failed, message\n #{req}" unless req == {"accepted"=>true}
  end

  def destroy
    rest = Rest.new
    req = rest.delete("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:repo]}/#{resource[:snapshot_name]}")
    fail "snapshot delete failed, message\n #{req}" unless req == {"acknowledged"=>true}
  end

end
