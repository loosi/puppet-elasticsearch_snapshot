

#test repo on localserver
es_repository { 'test':
  ensure   => present,
  type     => 'fs',
  settings => {
    'location' => '/tmp/bla'
  },
}
