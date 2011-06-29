require 'selenium-webdriver'

# this allows you, from within an integration test running with the 
# :selenium driver (aka Webdriver) to slow down the playback of a 
# test.  use like so:  set_speed :medium
# Based on code collaboration and improvements by JoshG 
# to my initial slow-down-capybara hack 

module ::Selenium::WebDriver::Remote      
  class Bridge
    @@speed = nil
    
    def self.speed
      @@speed  
    end
    
    def self.speed=(val)
      @@speed = speed
    end

      def execute(*args)
        result = raw_execute(*args)['value']
        unless isnt_an_action_command?(args.first.to_s)
          case Bridge.speed
            when :slow
              sleep 1.0
            when :medium
              sleep 0.5
            else
              sleep 0.2
          end
        end
        result
      end
    
    private
    
      # this identifies most non-action commands, so we are not delaying on 
      # things like assertions, housekeeping commands, etc. 
      def isnt_an_action_command?(cmd)
      !!(/^(get|find|is|assert|element|setImplicitWaitTimeout|setScriptTimeout|newSession).*/.match(cmd))
      end    
  end
end

def set_speed(speed)
  original_speed = ::Selenium::WebDriver::Remote::Bridge.speed
  ::Selenium::WebDriver::Remote::Bridge.speed = speed
  if block_given?
    yield
    ::Selenium::WebDriver::Remote::Bridge.speed = original_speed
  end
end


