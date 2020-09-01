class WallRentalRequestsController < ApplicationController


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


    private

    def wall_rental_request_params
        params.require(:wall_rental_request).permit(:start_date, :end_date, :wall_id, :status)
    end 
end 