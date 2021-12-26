# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # skip_before_action :authenticate_user!

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy 
  #   super
  # end

  private

  def after_sign_in_path_for(resource)
    root_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute, :password])
  # end
end
