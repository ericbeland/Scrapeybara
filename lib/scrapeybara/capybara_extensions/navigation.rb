module CapybaraExtensions
  module Navigation
      
    def scroll_to_me(el)
      page.execute_script("window.scrollTo(0,  window.innerHeight);")      
    end 
    
    
    # the has_finder
    def when_has?(find_type, find_path,  &block)         
      hasit = send "has_#{find_type}?", find_path
      yield
    end    
    
#   when_has?(:xpath, '//a[@id="cool"]' ) {click_on "cool"}
    
    
  end
end