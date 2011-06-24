require_relative 'navigation'
require_relative 'verifiers'
require_relative 'multi_assert'
require_relative 'results'
require_relative 'driver/driver_helpers'
require 'test/unit'

module CapybaraExtensions
  include Test::Unit::Assertions
  include CapybaraExtensions::DriverHelpers
  include CapybaraExtensions::MultiAssert
  include CapybaraExtensions::Navigation
  include CapybaraExtensions::Verifiers  
  include CapybaraExtensions::Results
end


# To Enable these Capybara extensions, just include like so:
# require 'capybara_extensions/capybara_extensions'
# 
# class ActionController::IntegrationTest
#  include CapybaraExtensions
# end



