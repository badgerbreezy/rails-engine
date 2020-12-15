class Transaction < ApplicationRecord

  validates :result, :credit_card_number, presence: true

  belongs_to :invoice
end
