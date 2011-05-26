relative_require 'spec_helper'

class VCRTest < Test::Unit::TestCase

  def test_example_dot_com
    VCR.use_cassette('synopsis') do
      #response = Net::HTTP.get_response(URI('http://www.iana.org/domains/example/'))
      #response.body
      
      
      
    end
  end
  
  
  
end
