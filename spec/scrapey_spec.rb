require_relative 'spec_helper.rb'
require_relative '../lib/scrapeybara'

describe 'Scrapebara' do
  include Scrapeybara
  
  context 'Scraping Results' do
  
    let :string do
    Capybara.string <<-STRING
    <div id="page">
      <div id="content">
          <h1 data="fantastic">Awesome</h1>
          <p>Yes it is</p>
        </div>
          <div id="footer" style="display: none">
          <p>c2010</p>
          <p>Jonas Nicklas</p>
          <input type="text" name="foo" value="bar"/>
          <select name="animal">
            <option>Monkey</option>
            <option selected="selected">Capybara</option>
          </select>
        </div>
      </div>
    STRING
  end
    
  
    before :each do  
      @result = Scrapeybara::Scraper::scrape(:default => :xpath) do  |s|
        s.listings :xpath => '//tr[@class=listing]' do |listing|    
          listing.hello      'td[@class=name]'   
          listing.hello do |h|
            h.goodbye 'bye' 
          end    
       end      
      end      
    end   
    
    it 'should return a result for listing' do
      @result.listings.nil?.should be_false
      @result.made_up_thing.nil?.should be_true      
      @result.listings.hello.nil?.should be_false      
    end    
  
    it 'should return the element for each item' do
     string.nil?.should be_false
    
    end
  
    it 'should provide json output format' do
      @result.to_json
    end
  
    it 'should provide xml output format' do
      @result.to_xml
    end
  
  end 
  
  context 'parameterization' do
    
    it 'should cycle through records' do
      p = Parameters.new("name,number\njohn,1234\nmary,4567", :selection_method => :use_all_records)
      row_1 = p.get_row(1)
      row_1.include?('john').should be_true
      row_1.include?('mary').should be_false    
      p.get_row(1).include?('mary').should be_true
    end
    
    it 'should repeat the record when given same identifier' do
      p = Parameters.new("name,number\njohn,1234\nmary,4567", :selection_method => :use_all_records)
      row = p.get_row(1)
      row.should == p.get_row(1)
    end    
    
  end
  
  
  
  it 'should use capybara' do
   # visit 'http://www.google.com'
  #  page.nil?.should be_false
  end
  
    
  
  context 'retries' do
  
    it 'should collect results of retries' do
      result = with_retry :limit => 3, :wait => 0.0001  do
        3
      end
      (result.last == 3).should be_true    
    end
  
    it 'should stop retrying after success' do
      retry_count = 0
      with_retry :limit => 3, :wait => 0.00001  do
        retry_count += 1                  
        raise "I am an exception" if retry_count == 1
      end
      (retry_count == 2).should be_true    
    end
  
    it 'should capture failure information' do
      result = with_retry :limit => 3, :wait => 0.00001  do
        retry_count += 1                  
        raise "I am an exception" if retry_count == 1
      end
      result.last.is_a?(Exception).should be_true
    end  
    
    it 'should run the optional reset block upon each retry' do
      @reset_called = 0
      reset = lambda { @reset_called += 1 }
      with_retry(:limit => 2, :wait => 0.00001, :reset => reset ) do
        raise 'foo'
      end  
      (@reset_called == 2).should be_true
    end
    
    it 'should run retry blocks the correct number of times' do
      retry_count = 0
      with_retry :limit => 3, :wait => 0.00001  do
        retry_count += 1
        raise 'Foo'        
      end
      retry_count.should == 3
    end

  end
  

end
    
