require_relative 'spec_helper.rb'
require_relative '../lib/scrapeybara'

describe 'Scrapebara' do
    
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
  
  it 'should use capybara' do
    visit 'http://www.google.com'
    page.nil?.should be_false
  end
  
  it 'should run retry blocks the correct number of times' do
    
  end
  
  it 'should collect failing results of retries' do
  
  end
  
  it 'should stop retrying after success' do
    
  end
  
  it 'should capture failure information' do
  
  end
  
  it 'should ' do
    
  end

end
    
