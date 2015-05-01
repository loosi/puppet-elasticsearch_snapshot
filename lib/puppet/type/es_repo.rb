# Class design
# es_repository { 'my_backup ':
#   ensure            => present,
#   type    => 'fs',
#   settings     => { 'location' => '/data/snap'
#                     'compress' => true },
# }
# some test text
Puppet::Type.newtype(:es_repo) do

  @doc = 'Create ES repo'

  ensurable

  newparam(:name) do
    desc 'Name of the repo'
    isnamevar
  end

  newparam(:type) do
    newvalues('fs','url')
    defaultto('fs')
  end

  newparam(:settings) do
    desc 'settings of repo in a ruby hash'
    validate do |value|
      raise ArgumentError, "%s is not a hash" % value unless value.is_a? Hash
    end
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
