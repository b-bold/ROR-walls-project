class WallRentalRequest < ActiveRecord::Base

    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), 
        message: "isn't valid"}
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true   
    validate :does_not_overlap_approved_request 

    belongs_to(
        :wall, 
        class_name: 'Wall',
        foreign_key: :wall_id,
        primary_key: :id
    )

    def overlapping_requests
        WallRentalRequest
            .where.not(id: self.id)
            .where(wall_id: wall_id)
            .where.not('start_date > :end_date OR end_date < :start_date',
                 start_date: start_date, end_date: end_date)


                 # Logic for the last line of the query:
                 # !( B(s) > A(e) ) && !( A(s) > B(e) )
    end 

    def overlapping_approved_requests
        array_of_requests = self.overlapping_requests
        approved_requests = []

        array_of_requests.each do |request|
            if request.status == "APPROVED"
                approved_requests << request
            end 
        end 
        approved_requests
    end 

    def overlapping_pending_requests
        array_of_requests = self.overlapping_requests
        pending_requests = []

        array_of_requests.each do |request|
           if request.status == "PENDING"
                pending_requests << request
            end 
        end 
        
        pending_requests
    end 

    def does_not_overlap_approved_request 
        if !self.overlapping_approved_requests.empty?
            errors[:base] << 'conflicts with other approved requests. Choose another start and end date.'
        end 

    end 
end 