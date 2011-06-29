require 'capybara'

module CapybaraExtensions::SeleniumDriverHeaders

  @@driver_headers = {
    :selenium_ie_7    =>    "Mozilla/5.0 (Windows; U; MSIE 7.0; Windows NT 6.0; en-US)",
    :selenium_ie_8    =>    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.2; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0)",
    :selenium_ie_9    =>    "Mozilla/5.0 (Windows; U; MSIE 9.0; Windows NT 9.0; en-US)",
    :selenium_ie_10   =>    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)",
    :selenium_ff_5_0  =>    "Mozilla/5.0 (X11; U; Linux i586; de; rv:5.0) Gecko/20100101 Firefox/5.0",
    :selenium_ff_4_0  =>    "Mozilla/5.0 (X11; U; Linux x86_64; pl-PL; rv:2.0) Gecko/20110307 Firefox/4.0"
  }


  def self.create_selenium_driver_with_headers(driver_name_sym, user_agent_string)
    Capybara.register_driver driver_name_sym do |app|
      require 'selenium/webdriver'
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['general.useragent.override'] = user_agent_string
      Capybara::Driver::Selenium.new(app, :profile => profile)
    end
  end

  def self.included(base)
    @@driver_headers.each do |key, value|
      self.create_selenium_driver_with_headers(key, value)
    end
  end


end
