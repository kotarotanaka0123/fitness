class GoalsController < ApplicationController
  def index
    @goal = current_user.goal
    @bmr = BMR.new(current_user).calc_bmr
    @during = (@goal.deadline - @goal.startday).to_i
    # 1日あたりの摂取目標
    @absorbCalorie = @bmr*1.1 - 7200*@goal.slim/@during
  end

  def body     
    render "goals/configBody"
  end

  def configBody
    body = user_params   #require(:user)を入れるとエラーになる。

    if current_user.update(body)
      redirect_to configCalorie_goals_path, notice: "更新しました。"
    else
      render :body
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

  def user_params
    params.permit(:weight, :height, :age)
  end

  def goal_params
    params.require(:goal).permit(:deadline, :slim)
  end

end

