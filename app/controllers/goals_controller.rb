class GoalsController < ApplicationController
  before_action :authenticate_user!
  
  layout 'noBar', except: :index
  
  def index
    @goal = current_user.goal
    @bmr = BMR.new(current_user)
    @during = @bmr.calc_span
    # NOTE: 1日あたりの摂取目標を算出
      @absorbCalorie = @bmr.calc_absorb_calorie
    if @absorbCalorie < 0
      redirect_to configCalorie_goals_path, notice: "適切な目標を入力してください"
    end

    @calc_predicted_result = @bmr.calc_predicted_result
  end

  def configCalorie
    if current_user.goal
      @goal = current_user.goal
    else
      @goal = current_user.build_goal
    end
  end

  def create
    goal = goal_params.merge(startday: Date.today)
    @goal = current_user.build_goal(goal)
    
    if @goal.save
      redirect_to goals_path
    else
      render :configCalorie
    end
  end

  def update
    goal = goal_params.merge(startday: Date.today)
    @goal = current_user.goal
    
    if @goal.update(goal)
      redirect_to goals_path
    else
      render :configCalorie
    end
  end
  
  private

  def goal_params
    params.require(:goal).permit(:deadline, :slim)
  end

end

