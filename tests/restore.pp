

#test repo on localserver
es_restore { 'test_snap':
  ensure        => present,
  snapshot_name => 'testsnap',
  repo          => 'aaa',
}
