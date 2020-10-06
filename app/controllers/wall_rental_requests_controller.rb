class WallRentalRequestsController < ApplicationController
    before_action :authorized_user, only: %i(approve deny)

    def index
        render :index
    end 

    def new
        @wall = Wall.all
        render :new
    end 

    def create
        @wall = WallRentalRequest.new(wall_rental_request_params)

        if @wall.save!
            redirect_to wall_rental_request_url(@wall)
        else 
            render :new
        end 
    end 

    def show
        @wallrentalrequest = WallRentalRequest.find_by(id: params[:id])
        @wall = Wall.find_by(id: @wallrentalrequest.wall_id)

        if @wallrentalrequest
            render :show
        else 
            redirect_to '/walls'
        end 
    end

    def approve
        wall_rental_request = WallRentalRequest.find_by(id: params[:id])
        wall_rental_request.approve!
        
        wall = Wall.find_by(id: wall_rental_request.wall.id)

        redirect_to wall_url(wall)
    end 

    def deny
        wall_rental_request = WallRentalRequest.find_by(id: params[:id])
        wall_rental_request.update!(status: "DENIED")

        wall = Wall.find_by(id: wall_rental_request.wall.id)

        redirect_to wall_url(wall) 
    end 


    private

    def wall_rental_request_params
        params.require(:wall_rental_request).permit(:start_date, :end_date, :wall_id, :status)
    end 
end 