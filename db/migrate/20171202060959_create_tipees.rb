class CreateTipees < ActiveRecord::Migration[5.1]
  def change
    create_table :tipees do |t|
      t.belongs_to :merchant
      t.string :account_num
      t.string :name
      t.text :qr_code
      t.timestamps
    end
  end
end

# - merchant_id
# - account_num
# - name
# - qr_code
