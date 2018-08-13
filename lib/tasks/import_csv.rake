require 'csv'
# require './app/models/merchant'


task :import_merchants => :environment do
  puts "Importing merchants..."
  csv_text = File.read('db/csv/merchants.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Merchant.create!(row.to_hash)
  end
end

task :import_invoices => :environment do
  puts "Importing invoices..."
  csv_text = File.read('db/csv/invoices.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Invoice.create!(row.to_hash)
  end
end

task :import_customers => :environment do
  puts "Importing customers..."
  csv_text = File.read('db/csv/customers.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Customer.create!(row.to_hash)
  end
end
