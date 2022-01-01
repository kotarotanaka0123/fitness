class AchievementController < ApplicationController
    def index
        @achievements = current_user.achievements.all
        # goals/indexで行っている処理と同じ。
        goal = current_user.goal
        bmr = BMR.new(current_user).calc_bmr
        during = (goal.deadline - goal.startday).to_i
        gon.absorbCalorie = bmr*1.1 - 7200*goal.slim/during

        gon.achievements_by_day = @achievements.group_by_day(:created_at).sum(:calorie)
        gon.achievementsLabels = gon.achievements_by_day.map(&:first).to_json.html_safe
        gon.achievementScore = gon.achievements_by_day.map(&:second)
    end
end
