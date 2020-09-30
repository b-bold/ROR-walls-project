class UsersController< ApplicationController

    def create 
        @user = User.new(user_params)
        if @user.save
            redirect_to session_url
        else
            flash.now[:errors] = @user.errors.full_messages
        end 
    end 

    def new
        @user = User.new
        render :new
    end 

    private

    def user_params
        params.require(:user).permit(:username, :password_digest, :session_token)
    end 

end 