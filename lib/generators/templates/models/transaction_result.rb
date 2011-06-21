class TransactionResult < ActiveRecord::Base
   belongs_to :runs
   has_many :steps
 
  # captures information about a scraping attempt, such as failures, screen captures, etc for debugging

  def step(name)
    current_step = Step.new(:name => name)
    yield @current_step if block_given?
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