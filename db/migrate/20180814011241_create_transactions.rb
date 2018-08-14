class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :customer, foreign_key: true
      t.references :merchant, foreign_key: true
      t.text :status
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
