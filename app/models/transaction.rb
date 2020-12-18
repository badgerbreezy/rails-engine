class Transaction < ApplicationRecord
  validates :result, :credit_card_number, presence: true

  belongs_to :invoice

  scope :successful, -> {where(result: "success")}
end
