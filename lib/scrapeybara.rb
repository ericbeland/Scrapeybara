require_relative 'scrapeybara/error_recovery'
require_relative 'scrapeybara/scrape'
require_relative 'scrapeybara/version'
require_relative 'scrapeybara/params' 
require_relative 'scrapeybara/step_results' 

require 'capybara'

#require_relative 'scrapeybara/steps'
#require_relative 'scrapeybara/transaction_result'

#require 'capybara'
#require 'capybara/dsl'

# Capybara.run_server = false

#Capybara.app_host = 'http://www.google.com'

module Scrapeybara
  
  def log
    return @log if @log
    return logger if respond_to?(:logger)
  end
  
  def log=(mylog)
    @log = mylog
  end
  
  include StepResults
  include ErrorRecovery
  include Scrape 
  include Capybara
  include Params
  
end