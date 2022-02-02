# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  #NOTE: ユーザ基本情報設定中にログイン画面に遷移しようとすると、ログイン画面にいかないので、強制的にログイン画面に遷移させた。
  prepend_before_action :require_no_authentication, only: [:cancel]
  skip_before_action :check_initial_setting

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    #NOTE: おそらくrequire_no_authenticationのせいでユーザが切り替わらないので、ユーザを更新。
    user = User.find_by(email: params[:user][:email])
    set_flash_message!(:notice, :signed_in)
    if user.present?
      sign_in(resource_name, user)
    else
      sign_in(resource_name, resource)
    end
    
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

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
