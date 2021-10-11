class AchievementController < ApplicationController
    def index
        @achievement = current_user.build_achievement
        @total = current_user.totals.find(current_user.totals.ids.max)
        @achievement.today = @total.protein*4 + @total.fat*9 + @total.carbon*4
        @achievement.save
    end
end
