require 'rake'
require 'rspec/core/rake_task'
require 'kitchen'

@instances = []
@config = Kitchen::Config.new(
                              :loader     => Kitchen::Loader::YAML.new('.kitchen.yml'),
                              :log_level  => :info,
                              :supervised => false
                              )
@names = %w{ default-app-server default-load-balancer default-apache-frontend }
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
  @instances.each {|i| i.converge }
  # @instances.each {|i| futures << i.future.converge }
  # blocks until all nodes have converged
  #futures.each {|f| f.value }
end

RSpec::Core::RakeTask.new(:spec)  do |t|
  t.pattern = "test/smoke/*_spec.rb"
end

task :test => [:create, :converge, :spec]
