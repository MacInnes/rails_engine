require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many :transactions}
  end
end
