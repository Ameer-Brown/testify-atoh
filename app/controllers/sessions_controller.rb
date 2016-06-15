class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.confirm(user_params)
        if @user && @user.authenticate(params[:user][:password])
            login(@user)
            redirect_to user_path(current_user)
        else
            flash[:error] = 'Invalid Username and/or Password Combination'
            redirect_to login_path
        end
    end

    def destroy
        logout
        redirect_to login_path
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
