class AddRequesterIdtoWallRentalRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :wall_rental_requests, :requester_id, :integer
    add_index :wall_rental_requests, :requester_id
  end
end
