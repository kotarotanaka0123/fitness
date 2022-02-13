# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :check_initial_setting

  layout 'noBar'

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  def confirm_email
  end

  def username
    @user = User.find(params[:id])
  end

  def addingUsername
    @user = User.find(params[:id])
    @user.assign_attributes(name: params[:user][:name])
    #NOTE: 体重身長などのバリデーションはここでは外したい。
    if @user.save(validate: false)
      #NOTE: ユーザ名登録後、すぐにログイン状態にしたい。
      sign_in(:user, @user)
      redirect_to body_details_path
    else
      render :username
    end
  end

  def body_details
    @user = current_user
  end

  def add_body_details
    body = user_params

    if current_user.update(body)
      redirect_to configCalorie_goals_path
    else
      render :body_details
    end
  end

  def changeUsername
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   username_registration_path
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    confirm_email_path
  end

  def user_params
    params.require(:user).permit(:weight, :height, :age)
  end
end
