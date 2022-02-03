class UsersController < ApplicationController

    def index
        @user = user_select
        @users = User.all
    end

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
    
        if @user.save
            redirect_to admin_user_url(@user), notice: "ユーザ「#{@user.name}」を登録しました。"
        else
            render :new
        end
    end
    
    def show
        @user = user_select
    end
    
    def edit
        @user = user_select
    end

    def update
        @user = user_select
        redirect_to user_path(@user) if @user.update(image: params[:user][:image])
    end

    private 
    
    def user_params
        params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end

    def user_select
        User.find(params[:id])
    end
end
