class UsersController < ApplicationController

    before_action :set_user, only: [:show]
    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
        @registrations = @user.registrations
        @liked_events = @user.liked_events
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, notice: "Thanks for signing up!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit

    end

    def update
        if @user.update(user_params)
            redirect_to @user, notice: "User updated successfully!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        redirect_to users_path, alert: "User deleted successfully!"
    end

private

    def user_params
        params.require(:user).
            permit(:name, :email, :username, :password, :password_confirmation)
    end

    def require_correct_user
        set_user
        redirect_to events_url, status: :see_other unless current_user?(@user)
    end

    def set_user
        @user = User.find_by!(slug: params[:id])
    end
end
