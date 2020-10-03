class UsersController< ApplicationController
    before_action :require_no_logged_in_user 
    
    def create 
        @user = User.new(user_params) 

        if @user.save
            login_user(@user)
            redirect_to walls_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end 
    end 

    def new
        @user = User.new
        render :new
    end 

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end 

end 