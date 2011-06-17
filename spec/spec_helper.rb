$:.unshift(File.expand_path('../lib', File.dirname(__FILE__)))

require 'rubygems'
require "bundler/setup"

require 'rspec'

require 'capybara/dsl' 
require 'vcr'

require_relative  '../lib/scrapeybara'

path = File.join(File.dirname(__FILE__), "spec/factories/**/*.rb")

RSpec.configure do |config| 
  include Capybara::DSL
end

Capybara.current_driver = :selenium
app_host = 'http://www.google.com'
Capybara.app_host = app_host
Capybara.run_server = false 
 
#VCR.config do |c|
#  c.cassette_library_dir = 'fixtures/vcr_cassettes'
#  c.stub_with :webmock # or :fakeweb
#end

