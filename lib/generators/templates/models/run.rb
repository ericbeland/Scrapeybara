class Run < ActiveRecord::Base
  has_many :transaction_results
  
end