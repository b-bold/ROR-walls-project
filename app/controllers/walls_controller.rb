class WallsController < ApplicationController
    before_action :authorized_user, only: %i(update edit) 
    
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
            flash.now[:errors] = @wall.errors.full_messages
            render :new
        end 
    end 

    def edit
        @wall = current_user.walls.find_by(id: params[:id])
        render :edit
    end 
    
    def update
        @wall = current_user.walls.find_by(id: params[:id])

        if @wall.update_attributes(wall_params)
            redirect_to wall_url(@wall)
        else 
            flash.now[:errors] = @wall.errors.full_messages
            render :edit
        end
    end  
    
    private

    def wall_params
        params.require(:wall).permit(:name, :coat_color, :construction_date, :wall_material, :description, :size, :owner_id)
    end

end 