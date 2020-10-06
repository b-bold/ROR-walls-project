class WallRentalRequest < ActiveRecord::Base

    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), 
        message: "isn't valid"}
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true   
    validates :requester_id, presence: true
    validate :does_not_overlap_approved_request 


    belongs_to(
        :wall, 
        class_name: 'Wall',
        foreign_key: :wall_id,
        primary_key: :id
    )

     belongs_to( 
        :requester,
        class_name: 'User',
        primary_key: :id,
        foreign_key: :requester_id
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

    def approve!
        transaction do 
            self.update(status: "APPROVED")
            self.save!

            @pending_overlapping_requests_array = self.overlapping_pending_requests
            
            @pending_overlapping_requests_array.each do |request|
                request.update!(status: "DENIED")
            end 
        end 

    end




    def deny!
        @pending_overlapping_requests_array.each do |request|
            request.update(status: "DENIED")
            request.save!
        end
    end 

    private

    def does_not_overlap_approved_request 
        if !self.overlapping_approved_requests.empty? && self.status == "APPROVED"
            errors[:base] << 'conflicts with other approved requests. Choose another start and end date.'
        end 

    end 
end 