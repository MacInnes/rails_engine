class TransactionSerializer < ActiveModel::Serializer
  attributes :credit_card_number, :id, :invoice_id, :result
end
