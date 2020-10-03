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
            redirect_to walls_url
        end 

    end 

    def destroy
        return nil if current_user.nil?
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end 


    private


end 
