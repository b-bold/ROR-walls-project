class CreateWallRentalRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :wall_rental_requests do |t|
       t.integer :wall_id
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, default: "PENDING"

      t.timestamps
    end
    add_index :wall_rental_requests, :wall_id, unique: true
  end
end
