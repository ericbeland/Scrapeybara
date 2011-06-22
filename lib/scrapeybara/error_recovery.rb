module ErrorRecovery  
    
  def with_retry(opts = {} , &block)
    options = {:limit => 3, :wait => 10, :reset =>nil }.merge(opts)
    results = []
    retries = 0
    until results.length > 0 and !(results.last.is_a?(Exception)) || (retries == options[:limit])
      begin
        retries += 1        
        results << yield        
      rescue Exception => e 
        results << e
        unless retries < options[:limit]          
          raise e
        end        
      end    
      (options[:reset].call rescue nil) if options[:reset]      
      sleep options[:wait]                      
    end
    results
  end      
  
  def step(name, options = {:retry => 0})
    results = with_retry(options[:retry]) do
      yield      
    end    
  end
  
end
