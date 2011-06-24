module CapybaraExtensions
  module Results

    def capture_errors
      case Capybara.current_driver 
        when :selenium
        selenium_error_screenshot
      else
        save_and_open_page
      end    
    end    
  
    def results_path=(var)
      @results_path = var
    end
    
    def results_path
      @results_path || File.join(::Rails.root, 'tmp')    
    end        

    def selenium_error_screenshot
      file_name = failures.last.gsub(/[^0-9A-Za-z]/,'_').slice(0, 40) + ".png"
      page.driver.browser.save_screenshot(File.join(results_path, file_name))       
    end
    
    def save_page(html)  
      name = File.join(results_path, "capybara-#{Time.new.strftime("%Y%m%d%H%M%S")}.html")
      FileUtils.mkdir_p(results_path)      
      FileUtils.touch(name) unless File.exist?(name)
      tempfile = File.new(name,'w')
      tempfile.write(rewrite_css_and_image_references(html))
      tempfile.close  
    end    
    
  end        
end