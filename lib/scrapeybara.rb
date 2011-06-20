require_relative 'scrapeybara/error_recovery'
require_relative 'scrapeybara/scrape'
require_relative 'scrapeybara/steps'
require_relative 'scrapeybara/transaction_result'
require_relative 'scrapeybara/version'

#require 'capybara'
#require 'capybara/dsl'

# Capybara.run_server = false

#Capybara.app_host = 'http://www.google.com'

module Scrapeybara
  
  include ErrorRecovery
  include Scrape
  include Steps
  include Capybara
  
end