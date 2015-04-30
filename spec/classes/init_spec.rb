require 'spec_helper'
describe 'elasticsearch_snapshot' do

  context 'with defaults for all parameters' do
    it { should contain_class('elasticsearch_snapshot') }
  end
end
