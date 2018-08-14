require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should belong_to :customer}    
  end
end
