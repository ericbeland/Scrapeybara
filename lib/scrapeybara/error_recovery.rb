module ErrorRecovery  
    
  def with_retry(opts = {} , &block)
    options = {:retry => 0, :wait => 10, :reset =>nil }.merge(opts)
    results = []
    retries = 0
    until results.length > 0 and !(results.last.is_a?(Exception)) || (retries == options[:retry])
      begin
        retries += 1        
        results << yield        
      rescue Exception => e 
        results << e
        unless retries < options[:retry]          
          raise e
        end        
      end    
      (options[:reset].call rescue nil) if options[:reset]      
      sleep options[:wait]                      
    end
    results
  end      
  
  
  
end
