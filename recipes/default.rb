#
# Cookbook Name:: tk-demo
# Recipe:: default
#
# Copyright (C) 2013 Bryan W. Berry
# 
# license: apache v2
#

user "tk" do
  supports :manage_home => true
end

include_recipe "rvm::system"

node.set['rvm']['default_ruby'] = "ruby-1.9.3-p327"
node.set['rvm']['gems'] = {
  'ruby-1.9.3-p327' => [
                        { :name => 'bundler' },
                        { :name => 'sinatra' },
                        { :name => 'pry' },
                        { :name => 'pry-doc' },
                        { :name => 'pry-nav' },
                        { :name => 'chef' }
                       ]
  
}

%w{ sinatra pry chef pry-doc }.each do |g|
  rvm_global_gem g
end

directory "/usr/local/tk-demo" do
  owner 'tk'
end

file "/usr/local/tk-demo/config.ru" do
  content <<-EOF
    require 'sinatra'
    require './tk-demo'
    run Sinatra::Application
  EOF
  owner "tk"
end

file "/usr/local/tk-demo/tk-demo.rb" do
  content <<-EOF
    get '/' do
      'Hello World'
    end
  EOF
  owner "tk"
end

template "/etc/init.d/hello_world" do
  source "init.erb"
  mode "0755"
end

service "hello_world" do
  action [:enable, :start]
end
