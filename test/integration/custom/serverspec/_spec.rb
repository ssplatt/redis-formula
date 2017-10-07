require 'spec_helper'

describe 'Redis Base' do
  include_examples 'redis base'
end

describe 'Redis Custom' do

  describe 'Packages' do
    describe package('redis-server') do
      it { should be_installed }
      its(:version) { should >= '3.2' }
    end
    describe package('redis-tools') do
      it { should be_installed }
      its(:version) { should >= '3.2' }
    end
    describe package('redis-sentinel') do
      it { should be_installed }
      its(:version) { should >= '3.2' }
    end
  end

  describe 'Config' do
    describe file('/etc/redis/redis.conf') do
      its(:content) { should match /port 8080/ }
      its(:content) { should match /bind 0.0.0.0/ }
      its(:content) { should match /min-slaves-to-write 0/ }
      its(:content) { should match /min-slaves-max-lag 11/ }
      its(:content) { should match /appendonly yes/ }
      its(:content) { should match /requirepass ThisIsAThing01020304/ }
      its(:content) { should match /cluster-enabled yes/ }
      its(:content) { should match /cluster-config-file nodes.conf/ }
      its(:content) { should match /cluster-node-timeout 5000/ }
    end
  end

  describe 'Services' do
    describe service('redis-sentinel') do
      it { should be_enabled }
      it { should be_running }
    end
    describe process("redis-sentinel") do
      its(:user) { should eq "redis" }
    end
  end

end
