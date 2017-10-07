require 'spec_helper'

describe 'Redis Base' do
  include_examples 'redis base'
end

describe 'Redis Default' do
  describe 'Config' do
    describe file('/etc/redis/redis.conf') do
      its(:content) { should match /port 6379/ }
      its(:content) { should match /bind localhost/ }
      its(:content) { should match /min-slaves-to-write 3/ }
      its(:content) { should match /min-slaves-max-lag 10/ }
      its(:content) { should match /appendonly no/ }
    end
  end
end
