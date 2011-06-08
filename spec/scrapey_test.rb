require 'rubygems'
require 'hashie'

class ScrapeNode < Hashie::Mash
  
  def self.create(node=ScrapeNode.new)    
    yield node if block_given?
    return node
  end  

  # calls capybara's find within the context of the current element in our ScrapeNode
  def contextual_find(args)
    self[:element].find(args)
  end
  
  def method_missing(*args, &block)
    if block_given?
      #items=contextual_find(args)
      #items.collect {|item| ScrapeNode.new(item, &block) }
     # self[args[0].to_s] = ScrapeNode.create(self, &block)      
    self[args.first.to_s] = yield ScrapeNode.create({args[1].to_s => nil }, &block) 
    else
      puts "args were: #{args.inspect}"
      if args.length  == 2
        self[args[0].to_s] = ScrapeNode.new(args[1]) 
      else
        return super
      end
    end
  end 
  
end

def scrape(options, &block)
  ScrapeNode.create( &block)
end

result = scrape(:type => :xpath) do  |s|
  s.listings :xpath => '//tr[@class=listing]' do |listing|
    listing.name  'td[@class=name]'    
    listing.address  'td[@class=address]'
  end
end

puts result