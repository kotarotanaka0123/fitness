class MealsController < ApplicationController
    before_action :current_user
    def index
        @meals = current_user.meals.all
    end

    def new
        @meal = current_user.meals.new
    end

    def create
        @meal = current_user.meals.new(meal_params)

        if @meal.save
            redirect_to meals_path
        end
    end

    def time
        binding.pry
        @meal = current_user.meals.find(params[:id])
        @time = 
    end

    def update
    end

    # def create  
    #     # ミールを作成する。
    #     @meal = current_user.meals.new(meal_type: params[:meal][:meal_type])
    #     @meal.save
    #     # フードidsを取得する。
    #     @food = Food.find(params[:meal][:food_id])
    #     # フードレコードにミールを紐付ける。
    #     @food.update(meal_id: @meal.id)
    
    #     # @food = @meal.foods.find(meal_params[:foods_attributes][:id])
    #     # if @meal.save
    #     # end
    # end

    private
    
    def meal_params
        params.require(:meal).permit!
    end
end
