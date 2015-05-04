
exec {'/bin/echo boe':
  creates => '/tmp/refresh',
  notify  => Es_snapshot['test_snap']
}
#test repo on localserver
es_snapshot { 'test_snap':
  #ensure        => present,
  snapshot_name => 'ookkffll',
  repo          => 'aaa',
  refreshonly   => true
}
