$:.unshift(File.expand_path('../lib', File.dirname(__FILE__)))

require 'rubygems'
require "bundler/setup"

require 'rspec'

require 'capybara/dsl' 
#require 'vcr'

require_relative  '../lib/scrapeybara'

path = File.join(File.dirname(__FILE__), "spec/factories/**/*.rb")

RSpec.configure do |config| 
  include Capybara
end

Capybara.current_driver = :selenium
Capybara.run_server = false
#Capybara.app_host = 'http://www.google.com'

#VCR.config do |c|
#  c.cassette_library_dir = 'fixtures/vcr_cassettes'
#  c.stub_with :webmock # or :fakeweb
#end

