class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
    
    def after_sign_in_path_for(resource)
        root_path
    end

    # def current_user
    #     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # end 
end
