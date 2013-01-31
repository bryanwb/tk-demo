require 'rake'
require 'rspec/core/rake_task'
require 'kitchen'


@instances = []
@config = Kitchen::Config.new('.kitchen.yml')
@names = %w{ app-server-node0 load-balancer-node1 apache-node2 }
@names.each {|name| @instances << @config.instances.get(name) }

# serial execution cuz virtualbox/vagrant can't parallelize this part
task :destroy do
  @names.each {|name| @config.instances.get(name).destroy }
end

task :create do
  # this happens serially because virualbox/vagrant can't handle
  # parallel vm creation
  @instances.each {|i| i.create }
end

task :converge => :create do
  futures = []
  # this happens in parallel
  @instances.each {|i| futures << i.future.converge }
  # blocks until all nodes have converged
  futures.each {|f| f.value }
end

RSpec::Core::RakeTask.new(:spec)  do |t|
  t.pattern = "test/smoke/*_spec.rb"
end
  
