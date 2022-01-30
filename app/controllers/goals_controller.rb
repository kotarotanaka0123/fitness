class GoalsController < ApplicationController
  # before_action -> {
  #   set_goal || set_username
  # }
  
  layout 'noBar', except: :index
  
  def index
    @goal = current_user.goal
    @bmr = BMR.new(current_user).calc_bmr
    @during = (@goal.deadline - @goal.startday).to_i
    # NOTE: 1日あたりの摂取目標を算出
    @absorbCalorie = @bmr*1.1 - 7200*@goal.slim/@during  
    if @absorbCalorie < 0
      redirect_to configCalorie_goals_path, notice: "適切な目標を入力してください"
    end
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

