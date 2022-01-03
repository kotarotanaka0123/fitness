class Achievement < ApplicationRecord
    belongs_to :user

    def createAchievement
        @achievement = current_user.achievements.new
        @total = current_user.totals.find(current_user.totals.ids.max)
        @achievement.calorie = @total.protein*4 + @total.fat*9 + @total.carbon*4
        @achievement.save
        @achievement.update(start_time: @achievement.created_at)        
    end
end
