module ErrorRecovery  
    
  def with_retry(opts = {} , &block)
    options = {:retry => 0, :delay => nil, :retry_wait => 10, :reset => nil }.merge(opts)
    results = []
    retries = 0
    until results.length > 0 and !(results.last.is_a?(Exception)) || (retries == options[:retry])
      begin
        retries += 1        
        results << yield        
      rescue Exception => e 
        results << e
        if retries < options[:retry]          
          (options[:reset].call rescue nil) if options[:reset]      
          sleep options[:retry_wait]
        else          
          raise e
        end
        sleep options[:delay] if options[:delay]
      end    
    end
    results
  end      
  
  
  
end
