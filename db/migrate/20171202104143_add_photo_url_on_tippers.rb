class AddPhotoUrlOnTippers < ActiveRecord::Migration[5.1]
  def change
    add_column :tippers, :photo_url, :string
  end
end
