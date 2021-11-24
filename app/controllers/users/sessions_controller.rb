# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!

  # GET /resource/sign_in
  def new
    render :layout => 'users/sessions/new'
  end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:email])

    if user.valid_password?(params[:password])
      binding.pry
      bypass_sign_in user
      redirect_to root_url
    else
      render :new, :layout => "users/sessions/new"
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute, :password])
  # end
end
