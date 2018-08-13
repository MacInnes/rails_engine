require 'csv'

task :import_merchants do
  puts "Importing merchants..."
  csv_text = File.read('../../db/csv/merchants.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Merchant.create!(row.to_hash)
  end
end

task :import_invoices do
  puts "Importing invoices..."
  csv_text = File.read('../../db/csv/invoices.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Invoice.create!(row.to_hash)
  end
end
