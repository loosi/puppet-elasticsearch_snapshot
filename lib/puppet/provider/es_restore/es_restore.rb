#
#
#
Puppet::Type.type(:es_restore).provide(:es_restore) do
  require File.join(File.dirname(__FILE__).split('/')[0..-2],'lib','rest.rb')

  def exists?
    rest = Rest.new
    fail "Repo: #{resource[:repo]} does not exists" unless rest.get("http://#{resource[:ip]}:#{resource[:port]}/_snapshot").has_key? resource[:repo]
    snaps = rest.get("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:repo]}/_all")['snapshots']
    check_snap = false
    snaps.each do |s|
      check_snap = true if s['snapshot'] == resource[:snapshot_name]
    end
    fail "Snapshot: #{resource[:snapshot_name]} does not exist " unless check_snap
    restored = rest.get("http://#{resource[:ip]}:#{resource[:port]}/.es_snapshot/restores/1")
    if restored['found']
      restored['_source']['restore_name'] == resource[:snapshot_name] ? true : false
    else
      false
    end
  end

  def create
    rest = Rest.new
    close_index if resource[:close_index]
    path_end = "#{resource[:snapshot_name]}/_restore"
    path_end = "#{path_end}?wait_for_completion=true" if resource[:wait_for_completion].to_s == 'true'
    index = resource[:indices].is_a?(Array) ? resource[:indices].join(',') : resource[:indices]
    index = indices_of_snap if index == '_all'
    data = {
      'indices'              => index,
      'partial'              => resource[:partial],
      'ignore_unavailable'   => resource[:ignore_unavailable],
      'include_global_state' => resource[:include_global_state]
    }
    req = rest.post("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:repo]}/#{path_end}", data)
    fail "restore failed, message\n #{req}" unless req == {"accepted"=>true}

    es_snap_index = {'settings' => {'number_of_replicas' => 0}}
    req = rest.put("http://#{resource[:ip]}:#{resource[:port]}/.es_snapshot",es_snap_index)
    fail "Could not create snapshot state index '.es_snapshot' message\n #{req}" unless req == {"acknowledged"=>true}

    completed = { 'restore_name' => resource[:snapshot_name] }
    req = rest.put("http://#{resource[:ip]}:#{resource[:port]}/.es_snapshot/restores/1",completed)
    fail "Failed to save state in document on ES, message\n #{req}" unless req['created']
  end

  def destroy

    rest = Rest.new
    req = rest.delete("http://#{resource[:ip]}:#{resource[:port]}/.es_snapshot/restores/1")
    fail "snapshot delete failed, message\n #{req}" unless req['found']
  end

  def latest
    puts 'running latest'
  end


  def close_index
    rest = Rest.new
    if resource[:indices].is_a?(Array)
      resource[:indices].each do |i|
        rest.post("http://#{resource[:ip]}:#{resource[:port]}/#{i}/_close",{})
        fail "Close of index: #{i} failed, message\n req" unless {"acknowledged"=>true}
      end
    else
      rest.post("http://#{resource[:ip]}:#{resource[:port]}/#{resource[:indices]}/_close",{})
      fail "Close of index: #{i} failed, message\n req" unless {"acknowledged"=>true}
    end
  end

  def indices_of_snap(filter=['.es_snapshot'])
    rest = Rest.new
    snaps = rest.get("http://#{resource[:ip]}:#{resource[:port]}/_snapshot/#{resource[:repo]}/_all")['snapshots']
    snap = Hash.new
    snaps.each do |s|
      snap = s if s['snapshot'] == resource[:snapshot_name]
    end
    snap['indices'] - filter
  end

end
