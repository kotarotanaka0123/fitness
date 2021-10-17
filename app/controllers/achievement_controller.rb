class AchievementController < ApplicationController
    def index
        @achievements = current_user.achievements.all
        # goals/indexで行っている処理と同じ。
        goal = current_user.goal
        bmr = BMR.new(current_user).calc_bmr
        during = (goal.deadline - goal.startday).to_i
        @absorbCalorie = bmr*1.1 - 7200*goal.slim/during
    end
end
