# Class design
# es_repository { 'my_backup ':
#   ensure            => present,
#   type    => 'fs',
#   settings     => { 'location' => '/data/snap'
#                     'compress' => true },
#
# some test text
Puppet::Type.newtype(:es_restore) do

  @doc = 'Create ES snapshot'

  ensurable

  newparam(:name) do
    desc 'Name of the resource'
    isnamevar
  end

  newparam(:snapshot_name) do
    desc 'Name of the snapshot'
  end

  newparam(:repo) do
    desc 'Name of the repository to snapshot to'
  end

  newparam(:indices) do
    defaultto('_all')
  end

  newparam(:close_index) do
    newvalues('true','false')
    defaultto('true')
  end

  newparam(:store_state) do
    desc 'create a doc in ES which can be used to check if restore has already been done'
    newvalues('true','false')
    defaultto('true')
  end


  newparam(:wait_for_completion) do
    desc 'Wait for compleion'
    newvalues('true','false')
    defaultto('false')
  end

  newparam(:ignore_unavailable) do
    desc 'Ignore unavailable indices'
    newvalues('true','false')
    defaultto('false')
  end

  newparam(:include_global_state) do
    desc 'Include global state in snapshot'
    newvalues('true','false')
    defaultto('false')
  end

  newparam(:partial) do
    desc 'If true snapshots will continue if not all shards are avaiable'
    newvalues('true','false')
    defaultto('false')
  end

  newparam(:replicas) do
    desc 'Number of replicas to use after restore'
    defaultto('default')
  end

  newparam(:ip) do
    desc 'IP of an elasticsearch host'
    defaultto('127.0.0.1')
  end

  newparam(:port) do
    desc 'Port of elasticsearch'
    defaultto('9200')
  end
end
