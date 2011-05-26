module ErrorRecovery
  
  def retry(opts = {} , &block)
    options = {:retries => 3, :wait => 10 }.merge(opts)
    result = []
    while result
      begin
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