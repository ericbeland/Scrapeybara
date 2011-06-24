require_relative 'scrapeybara/error_recovery'
require_relative 'scrapeybara/scrape'
require_relative 'scrapeybara/version'
require_relative 'scrapeybara/params' 
require_relative 'scrapeybara/step_results' 
require_relative 'scrapeybara/capybara_extensions/capybara_extensions'

require 'capybara'

#require_relative 'scrapeybara/steps'
#require_relative 'scrapeybara/transaction_result'

#require 'capybara'
require 'capybara/dsl'

# Capybara.run_server = false

#Capybara.app_host = 'http://www.google.com'

module Scrapeybara

  include StepResults
  include ErrorRecovery
  include Scrape 
  include Capybara
  include Params
  include CapybaraExtensions
    
  Capybara.default_driver = :selenium
  
  def log
    return @log if @log
    return logger if respond_to?(:logger)
  end
  
  def log=(mylog)
    @log = mylog
  end
  

  
end