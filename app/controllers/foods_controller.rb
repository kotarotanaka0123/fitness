class FoodsController < ApplicationController
  before_action :current_user
  def index
    @foods = current_user.foods.all
  end

  def new
    @food = current_user.foods.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.save
      redirect_to foods_path
    else
      render 'foods/new'
    end
  end

  def addToMeal
  end

  private

  def food_params
    params.require(:food).permit!
  end
end
