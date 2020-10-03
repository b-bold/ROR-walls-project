class SessionsController < ApplicationController
    before_action :require_no_logged_in_user only: %i(create new)

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
            login_user(@user)
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
