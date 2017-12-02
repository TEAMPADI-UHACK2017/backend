class CreateTippers < ActiveRecord::Migration[5.1]
  def change
    create_table :tippers do |t|
      t.string :account_num
      t.string :name
      t.timestamps
    end
  end
end

# - account_num
# - name
