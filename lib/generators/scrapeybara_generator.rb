require 'rails/generators/migration'
require 'rails/generators/active_record'

# http://www.railsdispatch.com/posts/how-rails-3-enables-more-choices-part-1
# rails generate scrapeybara:transactions

module Scrapeybara
  class TransactionsGenerator < Rails::Generator::Base
  
    source_root File.dirname(__FILE__) + '/templates'
  
    def self.next_migration_number(path)
      ActiveRecord::Generators::Base.next_migration_number(path)
    end  
  
    def copy_models
      copy_file "models/run.rb", "app/models/run.rb"
      copy_file "models/transaction_result.rb", "app/models/transaction_result.rb"
      copy_file "models/step.rb", "app/models/step.rb"      
    end
    
    def create_migrations
      migration_template "migrations/create_runs.rb", "db/migrate"
      migration_template "migrations/create_steps.rb", "db/migrate"
      migration_template "migrations/create_transaction_results.rb", "db/migrate"
    end
    
  end
  
end

