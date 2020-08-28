class CreateWalls < ActiveRecord::Migration[5.2]
  def change
    create_table :walls do |t|
      t.date :construction_date, null: false
      t.string :wall_material
      t.string :name, null: false
      t.text :description
      t.string :size, :limit => 6

      t.timestamps 
    end
  end
end
