module ErrorRecovery  
    
  def with_retry(opts = {} , &block)
    options = {:tries => 0, :delay => nil, :retry_wait => 10, :reset => nil }.merge(opts)
    results = []
    tries = 0
    until results.length > 0 and !(results.last.is_a?(Exception)) || (tries == options[:tries])
      begin
        tries += 1        
        results << yield        
      rescue Exception => e 
        results << e        
        (options[:reset].call rescue nil) if options[:reset]
        if tries <= options[:tries]                      
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