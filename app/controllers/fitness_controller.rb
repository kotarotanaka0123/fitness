class FitnessController < ApplicationController
  before_action :authenticate_user!

  def index
    #HACK: check_initial_settingでリダイレクトされるはずだが、そうならないため一時的に同じ状況を再現。
    return redirect_to body_details_path if current_user.goal.nil?

    @goal = current_user.goal
    @bmr = BMR.new(current_user).calc_bmr
    @during = (@goal.deadline - @goal.startday).to_i      # 1日あたりの摂取目標
    @absorbCalorie = @bmr*1.1 - 7200*@goal.slim/@during

    @total = current_user.totals.first
    gon.total = @total
    gon.user = current_user
    gon.bmr = BMR.new(gon.user).calc_bmr

    achievement = current_user.achievements.last
    if achievement.present?
      if @absorbCalorie <= achievement.calorie
        @residueCalorie = 0
        @goalPercentage = 100
        @overCalorie = achievement.calorie - @absorbCalorie
        @weightInc = @overCalorie/7200
      else
        @residueCalorie = @absorbCalorie - achievement.calorie
        # 目標を100%とすると現在のカロリーは ↓
        @goalPercentage = (@absorbCalorie-@residueCalorie)/@absorbCalorie*100
      end
    else
      @residueCalorie = @absorbCalorie
      @goalPercentage = 0
    end
  end
end
