class RenameTippeeToTipee < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :tippee_id, :tipee_id
  end
end
