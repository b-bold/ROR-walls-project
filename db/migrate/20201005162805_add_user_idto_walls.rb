class AddUserIdtoWalls < ActiveRecord::Migration[5.2]
  def change
    add_column :walls, :owner_id, :integer
  end
end
