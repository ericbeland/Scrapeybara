require_relative 'scrapybara/error_recovery'
require_relative 'scrapeybara/result_formatter'
require_relative 'scrapeybara/scrape_tree_node'
require_relative 'scrapeybara/scraper'
require_relative 'scrapeybara/steps'
require_relative 'scrapeybara/transaction_result'
require_relative 'scrapeybara/version'

require 'capybara'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.default_driver = :selenium
#Capybara.app_host = 'http://www.google.com'


module Scrapeybara
  
  include ErrorRecovery
  include ResultFormatter
  include ScrapeTreeNode
  include Scraper
  include Steps
  include TransactionResult
  include Capybara::DSL
  
  def scrape(settings={})
    scraper ||= Scraper.new(settings)
    scraper
  end

end
