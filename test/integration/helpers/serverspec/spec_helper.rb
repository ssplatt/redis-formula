require 'serverspec'
set :backend, :exec

shared_examples 'redis base' do

  describe 'Packages' do
    describe package('redis-server') do
      it { should be_installed }
      its(:version) { should >= '2.8' }
    end
    describe package('redis-tools') do
      it { should be_installed }
      its(:version) { should >= '2.8' }
    end
  end

  describe 'Config' do
    describe file('/etc/redis') do
      it { should be_directory }
      it { should exist }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 755 }
    end
    describe file('/etc/redis/redis.conf') do
      it { should be_file }
      it { should exist }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
    describe group('redis') do
        it { should exist }
    end
    describe user('redis') do
        it { should exist }
        it { should belong_to_group 'redis' }
        it { should have_login_shell '/bin/false' }
        it { should have_home_directory '/var/lib/redis' }
    end
  end

  describe 'Services' do
    describe service('redis-server') do
      it { should be_enabled }
      it { should be_running }
    end
    describe process("redis-server") do
      its(:user) { should eq "redis" }
    end
  end

end
