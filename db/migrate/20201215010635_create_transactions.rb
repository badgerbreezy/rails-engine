class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :result
      t.string :credit_card_number

      t.timestamps
    end
  end
end
