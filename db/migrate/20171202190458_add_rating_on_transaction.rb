class AddRatingOnTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :rating, :integer
  end
end
