

#test repo on localserver
es_repo { 'aaa':
  ensure   => present,
  type     => 'fs',
  settings => {
    'location' => '/tmp/boe'
  },
}
