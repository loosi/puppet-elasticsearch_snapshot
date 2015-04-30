

#test repo on localserver
es_snapshot { 'test_snap':
  ensure        => present,
  snapshot_name => 'testsnap',
  repo          => 'aaa',
}
