class WallRentalRequest < ActiveRecord::Base

    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), 
        message: "isn't valid"}
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true    

    belongs_to(
        :wall, 
        class_name: 'Wall',
        foreign_key: :wall_id,
        primary_key: :id
    )

    # def overlapping_requests

    # end 

end 