describe 'application proxying and load balancing' do

  require 'faraday'

  before do
    @url = "http://localhost:8080"
    @response = Faraday.get @url
  end
  
  it 'should say hello' do
    @response.body.should =~ /Hello World/
  end

  it 'should use mod_pagespeed' do
    @response.env[:response_headers].keys.should include("x-mod-pagespeed") 
  end

  it 'should return 200' do
    @response.env[:status].should == 200
  end
  
end
