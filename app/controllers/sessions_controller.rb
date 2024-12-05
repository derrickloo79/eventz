class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email_username]) || 
               User.find_by(username: params[:email_username])
        if user && user.authenticate(params[:password])
            # put user id in session
            session[:user_id] = user.id
            redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}!"
            session[:intended_url] = nil
        else
            flash.now[:alert] = "Invalid email/password combination"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to events_url, status: :see_other, notice: "You're now signed out!"
    end
end
