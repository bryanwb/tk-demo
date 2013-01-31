Overview        
========

This is a demo project to show how to use [test-kitchen](https://github.com/opscode/test-kitchen) for
multi-node integration tests. _Warning_, test-kitchen is still under
heavy development. The purpose of this demo is not to serve as a
canonical tutorial on test-kitchen but rather demonstrate the
fundamental concepts behind its operation. 

This demo spins up 3 nodes, an apache web server, a haproxy load
balancer, and a application server built on sinatra. The initial HTTP
request should traverse all 3 nodes and return the content "Hello World".

   GET /             -> apache -> haproxy -> app_server
   "Hello World"     <-        <-         <-

Prerequisites
=============

* Ruby 1.9
* The [bundler](http://gembundler.com/) gem
* [Virtualbox 4.2](http://virtualbox.org)


This project has only been tested on Ubuntu 11.10 and 12.10 but it
should work on any *nix.

Getting Started
===============

This tutorial relies heavily on [bundler](http://gembundler.com/). The
`rake` and `kitchen` commands will fail unless you prefix them with
`bundle exec`.

To get started

```Shell
  $ git clone https://github.com/bryanwb/tk-demo 
  $ bundle install
```

To spin up all 3 nodes and then run the RSpec tests to test the final state

```Shell
  $ bundle exec rake test
  # spins up 3 nodes, converges them, then executes rspec tests
```

To destroy everything

```Shell
  $ bundle exec rake destroy
  # destroys all 3 virtualbox vms
```

*Note:* I experienced some very strange issues with VirtualBox
 networking while creating this tutorial. Rebooting your host
 operating system usually fixes it.


The [Rspec](https://www.relishapp.com/rspec) tests are located in
`test/smoke/hello_spec.rb`



Special Thanks To
=================

Fletcher Nichol, Joshua Timberman, Seth Chisamore, Andrew Crump, Erik
Hollensbe, Seth Vargo, Mike Fiedler and many others for creating
test-kitchen and its previous incarnations. RIP Jamie-CI, long live
Test-Kitchen!



License and Author
==================

Author::                Bryan W. Berry (<bryan.berry@gmail.com>)  
Copyright::             2012, Bryan W. Berry  


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
