class ScrapeTreeNode < BasicObject
  
  include Capybara  
  
  def initialize(name, &block)
    instance_eval &block
    @children = []
  end

  def method_missing(meth, *args, &block)
    @children << ScrapeTreeNode.new(meth.to_s)  
  end  
  
end
