class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :merchant, foreign_key: true
      t.references :customer, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
