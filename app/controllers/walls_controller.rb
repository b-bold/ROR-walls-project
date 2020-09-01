class WallsController < ApplicationController
    
    def index
        @walls = Wall.all
        render :index
    end 

    def show 
        @wall = Wall.find_by(id: params[:id])
        @wallrentalrequest = @wall.requests.order(:start_date)

        if @wall
            render :show
        else 
            redirect_to '/walls'
        end 
    end 

    def new
        @wall = Wall.new
        render :new
    end

    def create
        @wall = Wall.new(wall_params) 
        
        if @wall.save!
            redirect_to wall_url(@wall)
        else 
            render :new
        end 
    end 

    def edit
        @wall = Wall.find_by(id: params[:id])
        render :edit
    end 
    
    def update
        @wall = Wall.find_by(id: params[:id])

        if @wall.update_attributes(wall_params)
            redirect_to wall_url(@wall)
        else 
            render :edit
        end
    end 

    private

    def wall_params
        params.require(:wall).permit(:name, :coat_color, :construction_date, :wall_material, :description, :size)
    end
end 