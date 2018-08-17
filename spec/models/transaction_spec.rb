require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :invoice_id}
    it {should validate_presence_of :credit_card_number}
    it {should validate_presence_of :result}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
  end

  describe 'Relationships' do
    it {should belong_to :invoice}
  end
end
