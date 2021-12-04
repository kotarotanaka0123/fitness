class FitnessController < ApplicationController
  before_action :authenticate_user!

  def index
    return redirect_to configBody_goals_path if current_user.goal.nil?
    
    @goal = current_user.goal
    @bmr = BMR.new(current_user).calc_bmr
    @during = (@goal.deadline - @goal.startday).to_i      # 1日あたりの摂取目標
    @absorbCalorie = @bmr*1.1 - 7200*@goal.slim/@during
  end
end
