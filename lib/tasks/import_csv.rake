require 'csv'

task :import_data => :environment do
  puts "Importing merchants..."
  csv_text = File.read('db/csv/merchants.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Merchant.create!(row.to_hash)
  end
  puts "Imported #{Merchant.count} merchants."

  puts "Importing customers..."
  csv_text = File.read('db/csv/customers.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Customer.create!(row.to_hash)
  end
  puts "Imported #{Customer.count} customers."

  puts "Importing invoices..."
  csv_text = File.read('db/csv/invoices.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Invoice.create!(row.to_hash)
  end
  puts "Imported #{Invoice.count} invoices."

  puts "Importing transactions..."
  csv_text = File.read('db/csv/transactions.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Transaction.create!(row.to_hash)
  end
  puts "Imported #{Transaction.count} transactions."

  puts "Importing items..."
  csv_text = File.read('db/csv/items.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Item.create!(row.to_hash)
  end
  puts "Imported #{Item.count} items."

  puts "Importing invoice items..."
  csv_text = File.read('db/csv/invoice_items.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    InvoiceItem.create!(row.to_hash)
  end
  puts "Imported #{InvoiceItem.count} invoice items."
  puts 'All data successfully imported.'
end

task :import_merchants => :environment do
  puts "Importing merchants..."
  csv_text = File.read('db/csv/merchants.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Merchant.create!(row.to_hash)
  end
  puts "Imported #{Merchant.count} merchants."
end

task :import_invoices => :environment do
  puts "Importing invoices..."
  csv_text = File.read('db/csv/invoices.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Invoice.create!(row.to_hash)
  end
  puts "Imported #{Invoice.count} invoices."
end

task :import_customers => :environment do
  puts "Importing customers..."
  csv_text = File.read('db/csv/customers.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Customer.create!(row.to_hash)
  end
  puts "Imported #{Customer.count} customers."
end

task :import_transactions => :environment do
  puts "Importing transactions..."
  csv_text = File.read('db/csv/transactions.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Transaction.create!(row.to_hash)
  end
  puts "Imported #{Transaction.count} transactions."
end

task :import_items => :environment do
  puts "Importing items..."
  csv_text = File.read('db/csv/items.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Item.create!(row.to_hash)
  end
  puts "Imported #{Item.count} items"
end

task :import_invoice_items => :environment do
  puts "Importing invoice items..."
  csv_text = File.read('db/csv/invoice_items.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    InvoiceItem.create!(row.to_hash)
  end
  puts "Imported #{InvoiceItem.count} invoice items"
end
