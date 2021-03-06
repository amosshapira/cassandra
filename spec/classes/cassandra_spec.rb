require 'spec_helper'
describe 'cassandra' do

  context 'On a RedHat OS with defaults for all parameters' do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    it { should contain_class('cassandra') }
    it { should contain_class('cassandra::install') }
    it { should contain_class('cassandra::config') }
    it { should contain_file('/etc/cassandra/default.conf/cassandra.yaml') }
    it { should contain_service('cassandra') }
    it { is_expected.not_to contain_yumrepo('datastax') }
  end

  context 'On a RedHat OS with manage_dsc_repo set to true' do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    let :params do
      {
        :manage_dsc_repo => true
      }
    end

    it { should contain_yumrepo('datastax') }
  end

  context 'On a Debian OS with defaults for all parameters' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it { should contain_class('cassandra') }
    it { should contain_service('cassandra') }
    it { should contain_class('cassandra::install') }
    it { should contain_class('cassandra::config') }
    it { should contain_file('/etc/cassandra/cassandra.yaml') }
    it { is_expected.not_to contain_class('apt') }
    it { is_expected.not_to contain_class('apt::update') }
    it { is_expected.not_to contain_apt__key('datastaxkey') }
    it { is_expected.not_to contain_apt__source('datastax') }
    it { is_expected.not_to contain_exec('update-cassandra-repos') }
  end

  context 'On a Debian OS with manage_dsc_repo set to true' do
    let :facts do
      {
        :osfamily => 'Debian',
        :lsbdistid => 'Ubuntu',
        :lsbdistrelease => '14.04'
      }
    end

    let :params do
      {
        :manage_dsc_repo => true
      }
    end

    it { should contain_class('apt') }
    it { should contain_class('apt::update') }
    it { is_expected.to contain_apt__key('datastaxkey') }
    it { is_expected.to contain_apt__source('datastax') }
    it { is_expected.to contain_exec('update-cassandra-repos') }
  end

  context 'On an unknown OS with defaults for all parameters' do
    let :facts do
      {
        :osfamily => 'Darwin'
      }
    end

    it {
      expect {
        should raise_error(Puppet::Error)
      }
    }
  end
end
