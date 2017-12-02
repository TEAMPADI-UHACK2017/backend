class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :tippee
      t.belongs_to :tipper
      t.decimal :amount, precision: 8, scale: 2
      t.timestamps
    end
  end
end
