class SessionController < ApplicationController

    def new
        @session = Session.new
        render user_url
    end 

    def create

    end 

    def destroy

    end 

    private


end 
