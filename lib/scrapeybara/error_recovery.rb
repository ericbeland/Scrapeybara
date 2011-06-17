module ErrorRecovery
  
  def retry(opts = {} , &block)
    options = {:retries => 3, :wait => 10 }.merge(opts)
    result = []
    success = nil
    retries = options[:retries]
    until success || retries == 0 
      begin
        retries -= 1
        success = block.call
      rescue Exception => e 
        result << e
      end    
      if success
        result << success
      else        
        sleep options[:wait]                  
      end
    end
    result
  end    
  
  
end