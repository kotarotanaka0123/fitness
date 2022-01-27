class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action -> {
        current_user && set_username && set_goal
    }

    protected

    def configure_permitted_parameters 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    def set_goal
        unless current_user.goal.deadline && current_user.goal.slim
            unless current_user.weight && current_user.height && current_user.age
                redirect_to configBody_goals_path
            else
                redirect_to configCalorie_goals_path
            end
        else
            # 何もしない
        end
    end

    def set_username
        redirect_to add_username_path unless current_user.name.present?
    end
end
