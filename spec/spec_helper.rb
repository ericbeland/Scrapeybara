$:.unshift(File.expand_path('../lib', File.dirname(__FILE__)))

require 'rubygems'
require 'test/unit'
require "bundler/setup"

require 'rspec'
require 'capybara'
require 'capybara/spec/driver'
require 'capybara/spec/session'
require 'vcr'


VCR.config do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.stub_with :webmock # or :fakeweb
end

Spec::Runner.configure do |config|


end