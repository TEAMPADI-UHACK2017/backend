class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.float :long
      t.float :lat
      t.string :name
      t.timestamps
    end
  end
end
