# RailsEngine

RailsEngine is a Rails api application that provides data from a number of resources, and produces business logic for a number of different metrics.  It's built on Rails 5.1.6 and Postgresql 10.4, and returns JSON data at each endpoint.  This project was created by Colin Armstrong (github: [colinwarmstrong](https://github.com/colinwarmstrong)) and Andrew Mockett(github: MacInnes) for Turing's Backend Engineering program.

# Setup:

First, clone this repository onto your computer:
```
git clone git@github.com:MacInnes/rails_engine.git
```
Then be sure to run `bundle install` from inside the project directory.  Once that is complete, run the following command to create the database:
```
rake db:{drop,create,migrate}
```
In order to seed the database with the included CSV data, simply run the following command:
```
rake import_data
```
If everything is setup correctly, you should be able to run `rspec` from the command line to run our local test suite.

# Gems used:
* Active_Model_Serializers
* Byebug
* Factory-Bot
* Faker
* Pry
* Rspec-Rails
* SimpleCov
* Shoulda-Matchers
* Spring

# API Endpoints:

There are 6 main resources used in this application:
* Merchants
* Customers
* Items
* Invoices
* Invoice_items
* Transactions

For each of these 6 resources, there are endpoints for showing all records or a single record:
* GET `/api/v1/(resource_name)`
* GET `/api/v1/(resource_name)/:id`

In addition, there are a few related endpoints as well:
* GET `/api/v1/(resource_name)/:id/(related_resource_name)`

The related resources are:
* Merchants: Items, Invoices
* Invoices: Transactions, Invoice_items, Items, Customer, Merchant
* Invoice_items: Invoices, Items
* Items: Invoice_items, Merchants
* Transactions: Invoices
* Customers: Invoices, Transactions

There are also a number of Business Intelligence endpoints:
* GET `/api/v1/merchants/most_revenue?quantity=x`
* GET `/api/v1/merchants/most_items?quantity=x`
* GET `/api/v1/merchants/revenue?date=x`
* GET `/api/v1/merchants/:id/revenue`
* GET `/api/v1/merchants/:id/revenue?date=x`
* GET `/api/v1/merchants/:id/favorite_customer`
* GET `/api/v1/merchants/:id/customers_with_pending_invoices`
* GET `/api/v1/items/most_revenue?quantity=x`
* GET `/api/v1/items/most_items?quantity=x`
* GET `/api/v1/items/:id/best_day`
* GET `/api/v1/customers/:id/favorite_merchant`
