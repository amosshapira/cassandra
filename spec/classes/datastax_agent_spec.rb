require 'spec_helper'
describe 'cassandra::datastax_agent' do

  context 'Test for cassandra::datastax_agent.' do
    it {
      should contain_class('cassandra::datastax_agent').with_package_ensure('present')
      should contain_class('cassandra::datastax_agent').with_package_name('datastax-agent')
      should contain_class('cassandra::datastax_agent').with_service_enable('true')
      should contain_class('cassandra::datastax_agent').with_service_ensure('running')
      should contain_class('cassandra::datastax_agent').with_service_name('datastax-agent')
    }
  end

  context 'Test for cassandra::datastax_agent package.' do
    it {
      should contain_package('datastax-agent')
    }
  end

  context 'Test for cassandra::datastax_agent service.' do
    it {
      should contain_service('datastax-agent')
    }
  end
end
