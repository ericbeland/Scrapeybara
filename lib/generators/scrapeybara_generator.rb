# lib/generators/make_voteable/make_voteable_generator.rb
require 'rails/generators/migration'
require 'rails/generators/active_record'


class ScrapeybaraGenerator < Rails::Generator::Base
  
  def self.source_root
    @source_root ||= File.dirname(__FILE__) + '/templates'
  end
 
  def self.next_migration_number(path)
    ActiveRecord::Generators::Base.next_migration_number(path)
  end  
  
  def manifest
    record do |m|
      # Models
      m.file "models/run.rb", "app/models/run.rb"
      m.file "models/transaction_result.rb", "app/models/transaction_result.rb"
      m.file "models/step.rb", "app/models/step.rb"

      # Tests 
      # m.file "test/unit/run_test.rb", "test/unit/run_test.rb"
    
      m.migration_template "migrations/create_runs.rb", "db/migrate"
      m.migration_template "migrations/create_steps.rb", "db/migrate"
      m.migration_template "migrations/create_transaction_results.rb", "db/migrate"
      
      m.readme "INSTALL me for activerecord storage of transaction and step results"
    end
  end

  def file_name
    "create_transaction_results"
  end

end
