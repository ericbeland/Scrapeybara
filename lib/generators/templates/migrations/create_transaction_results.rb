class CreateTransactionResults < ActiveRecord::Migration
  
  def self.up
    create_table :transaction_results do |t|
      t.column :id, :integer
      t.column :run_id, :integer  
      t.column :delay_min, :integer
      t.column :delay_max, :integer
      t.timestamps      
    end
  end

  def self.down
    drop_table :transaction_results
  end
  
end