class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :check_initial_setting

    protected

    def configure_permitted_parameters 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    def set_goal
        return if current_user.goal.deadline.present? && current_user.goal.slim.present?

        if current_user.weight.present? && current_user.height.present? && current_user.age.present?
            redirect_to configCalorie_goals_path
        else
            redirect_to configBody_goals_path
        end
    end

    def username?
        current_user.name.present?
    end

    def body_details?
        current_user.weight.present? && current_user.height.present? && current_user.age.present?
    end

    def check_initial_setting
        if current_user
            return redirect_to username_registration_path(current_user), error: "ユーザ名を入力してください" unless :username?
            return redirect_to body_details_path, error: "あなたの身体情報を入力してください" unless :body_details?
        else
            return
        end
    end
end
