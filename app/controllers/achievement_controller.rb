class AchievementController < ApplicationController
    before_action :authenticate_user!
    
    #下記のような記述だと、二重にアクセスされるため、本当はよくないだろうが、とりあえずこのまま。
    def index
        @achievements = current_user.achievements.all
        # goals/indexで行っている処理と同じ。
        goal = current_user.goal
        bmr = BMR.new(current_user).calc_bmr
        during = (goal.deadline - goal.startday).to_i
        gon.absorbCalorie = bmr*1.1 - 7200*goal.slim/during
    
        respond_to do |format|
            format.html
            format.json {
                span = params[:span].to_i
                oldAchievements = @achievements.group_by_day(:created_at, last: span+1).sum(:calorie).map(&:second)
                render json: { achievements: oldAchievements }
            }
        end
    end
end
