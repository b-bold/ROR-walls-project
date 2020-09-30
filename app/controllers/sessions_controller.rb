class SessionsController < ApplicationController

    def new
        render :new
    end 

    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        
        if @user.nil?
            flash.now[:errors] = ["Incorrect username and/or password"]
            render :new
        else
            session[:session_token] = @user.reset_session_token!
            render walls_url
        end 

    end 

    def destroy

    end 

    private


end 
