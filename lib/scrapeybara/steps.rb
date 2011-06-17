module Steps
  
  def step(name, options={})
    @transaction_result ||= TransactionResult.new()    
    @transaction_result[name] ||= []
    c = Hashie::Clash.new


    begin
      result = yield
    rescue Exception => e
      
    end
      
  end
  
  
  def transaction_result
    
  end
  
  
end