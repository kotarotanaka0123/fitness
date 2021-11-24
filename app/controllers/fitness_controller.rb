class FitnessController < ApplicationController
  def index
    binding.pry
    @goal = current_user.goal
    @bmr = BMR.new(current_user).calc_bmr
    @during = (@goal.deadline - @goal.startday).to_i
    # 1日あたりの摂取目標
    @absorbCalorie = @bmr*1.1 - 7200*@goal.slim/@during
  end
end
