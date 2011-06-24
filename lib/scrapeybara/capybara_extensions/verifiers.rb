module CapybaraExtensions
  module Verifiers
  
    def verify_links(links)
      links.each do |link, txt|
        click_link link
        assert_has_content?(txt)
      end
    end
    
    # yields the key part of a hash (which should have search term(s) in it, either as
    # another hash {:first=>'eric', :last+>'beland'}, or as a string) value each time before
    # it asserts items in the values.  Each yield should be re-running a search, for example
    def yield_then_verify(terms_hash)
      terms_hash.each do |term, assertion_hash |
        yield term if block_given?
          assertion_hash.each {|assertion, values| send(assertion, values) }
        end
    end
  
    # verify a hash like {'link_name'=>'content should have when clicked'}
    # by navigating through each item
    def click_and_verify(item_hash)
      item_hash.each do |item, content|
        click_on item
        assert_has_in_html?(content)
        yield if block_given? # yield to run block with extra verification
      end
    end  

    def verify_email(options={})
    email = ActionMailer::Base.deliveries.first 
      assert !email.nil?, "Email was nil"   
      if options[:subject]
        assert_equal options[:subject], email.subject, "Subject was: #{email.subject}, not #{options[:subject]}"      
      end
      if options[:to]
        assert email.to.include?(options[:to]), "To field contained #{email.to} not #{options[:to]}" 
      end
      if options[:body]
        [options[:body]].flatten.each do |item_to_match|
          assert_match item_to_match, email.encoded   
        end
      end
    end
  
    def assert_has_in_html?(strings_or_regexps)
      items = [strings_or_regexps].flatten
      items.each do |item|
        assert body.to_s.match(item), "HTML Didn't contain #{item}"
      end
    end
  
  end
end