class Step < ActiveRecord::Migration

  def self.up
    create_table :steps do |t|
      t.column :id, :integer
      t.column :transaction_result_id, :integer  
      t.column :name, :string
      t.column :error, :string
      t.column :result, :string
      t.column :http_results, :string
      t.column :started_at, :datetime
      t.column :ended_at, :datetime
      t.timestamps      
    end
  end

  def self.down
    drop_table :transaction_result
  end

end
