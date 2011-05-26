class Scraper
  
  def initialize(opts = nil)
    @outputter = opts[:outputter] || ObjectyHash.new # what to  
    @result_outputter = opts[:result_outputter] || LogResultOutputter.new 
  end   
  
end