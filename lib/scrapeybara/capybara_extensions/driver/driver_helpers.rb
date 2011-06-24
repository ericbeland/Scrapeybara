require_relative 'webdriver_throttle'

module CapybaraExtensions::DriverHelpers
  
  def with_driver(driver_sym ,&block)
    original_driver = Capybara.current_driver
    begin      
      Capybara.current_driver = driver_sym
      yield
    ensure
      Capybara.current_driver = original_driver
    end
  end
  
  def disable_akephalos_errors(&block)
    Capybara.register_driver :akephalos do |app|
      Capybara::Driver::Akephalos.new(app, :validate_scripts => false)
    end
    begin      
      yield 
    rescue NativeException => e # class for HTML Unit exceptions
      raise e unless ignored_exception?(e)
    ensure
      Capybara.register_driver :akephalos do |app|
        Capybara::Driver::Akephalos.new(app, :validate_scripts => true)
      end    
    end
  end 
  
  def ignored_exception?(e)
    e.to_s.include?('GetOfficeMap') or e.to_s.include?('_trackPageview')
  end
  
end