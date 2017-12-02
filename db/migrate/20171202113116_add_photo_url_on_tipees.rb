class AddPhotoUrlOnTipees < ActiveRecord::Migration[5.1]
  def change
    add_column :tipees, :photo_url, :string
  end
end
