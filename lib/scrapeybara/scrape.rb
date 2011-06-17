require 'rubygems'
require 'hashie'

module Scrape
  
  class Scraper < Hashie::Mash
    attr_accessor :options, :element
  
    def self.scrape(options, &block)
      return (yield Scraper.create({:options => options}))
    end
  
    def self.create(element = nil, options = {:default => :xpath})
      s = Scraper.new()
      s.options = options
      s.element =  element # context of where I am in the document, so I can be searched-within
      s
    end  
  
  def extract(item_locator)     
      return item_locator # stub 
      if item_locator.is_a?(Hash)      
        finder_key = item_locator[:xpath] ? :xpath : :css      
        path = item_locator[finder_key]      
        # default is all elements if nothing is passed
        # if parent is selected, we use element.find
        # if an array is passed, we grab the elements out of the array into an array
        # of pure capuybara elements and pass to capybara find
        context = item_locator[:context]    
        
      else
        find_type = options[:finder]
      end
      value = find(find_type, path)
    end
  
  def method_missing(method, *args)
    if block_given?  
        self[method] = yield Scraper.new()
        
        # for an array of results, yield each one into the sub block
        # so we can send in context
        if self[method].is_a?(Array)
          results = []
          self[method].map  do |item|
            results <<  {item => {method => (yield Scraper.create(item, self.options)) }}
          end
        end
        
        # if we want to be contextual, here we yield each result we already have, if we have them
        # then we set that result's 
      else
        case args.length
        when 1 # set value        
            current_items = extract(args[0])  
            self[method] =  current_items # 1st time, not an array
          when 0 
            return self[method]
          end    
        end
      self
    end     
  end  


end