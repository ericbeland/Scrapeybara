module StepResults

  def step(step_name, options = {:retry => 0, })
    log.info("Starting #{step_name}") if log
    step_obj = Step.new(step_name) if defined?(Step)       

    results = with_retry(:retry => options[:retry]) do
      start_time = Time.now  
      yield      
      duration_time = Time.now - start_time        
      if step_obj
        step_obj.duration = duration_time
        step_obj.save!
      end
    end           
  
    log.info("Completed #{step_name} in #{duration_time}") if log
    results
  end


end