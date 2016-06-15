class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def edit
        logged_in? @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if allowed?(@user.id) && @user.update(profile_params)
            flash[:notice] = 'Account successfully updated'
            redirect_to user_path
        else
            redirect_to user_path(@user)
            flash[:error] = 'You dont have access to this account'
        end
    end

    def create
        @user = User.create(user_params)
        login(@user)
        redirect_to @user
    end

    def show
        @user = User.find_by_id(params[:id])
        render :show
    end

    def destroy
        user = User.find_by_id(params[:id])
        if allowed?(user.id) && user.destroy
            flash[:notie] = 'Sorry to see you go. Account successfully deleted'
            redirect_to index_path
        else
            redirect_to user_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
    end

    def profile_params
        params.require(:user).permit(:first_name, :last_name,:username, :avatar, :email, :password)
    end
end
