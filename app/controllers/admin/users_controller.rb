class Admin::UsersController < ApplicationController
  before_action :login_required, except: :new

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
    @user = User.find(params[:id])
  end

  def index
    @user = User.find(params[:id])
    @users = User.all
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
