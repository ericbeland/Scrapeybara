class TransactionResult < ActiveRecord::Base
   has_many :steps
 
  # captures information about a scraping attempt, such as failures, screen captures, etc for debugging

  def step(name)
    current_step = Step.new(name)
    yield @current_step if block_given?
  end
  
  def step_begin(name)
    steps << Step.new(name)
  end

  def step_end
    current_step = Step.new(name)    
  end  
  
  def current_step
    steps.last unless finished
  end  
  
  def result
    steps.last.result    
  end

  def failed?
    steps.last.error
  end
  
end