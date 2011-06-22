class TransactionResult < ActiveRecord::Base
   belongs_to :runs
   has_many :steps
 
  # captures information about a scraping attempt, such as failures, screen captures, etc for debugging
        
  def think_time=(val)
    self.delay_min =  val.is_a?(Hash) ? val[:min] : val
    self.delay_max =  val.is_a?(Hash) ? val[:max] : val  
  end
    
  def delay
    rand(think_time[:max] - think_time[:min]) + think_time[:min]
  end

  def step(name, options = {})
    @current_step = Step.new(:name => name)
    yield @current_step if block_given?    
    sleep(delay)
  end
  
  def step_begin(name)
    steps << Step.new(:name => name)
  end

  def step_end
    current_step.ended_at = Time.now
    current_step.save!
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