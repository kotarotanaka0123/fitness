class MealsController < ApplicationController
    before_action :current_user
    def index
        @meals = current_user.meals.where(meal_type: nil)

        @breakfast = current_user.meals.where(meal_type: 'breakfast')
        @lunch = current_user.meals.where(meal_type: 'lunch')
        @between = current_user.meals.where(meal_type: 'between')
        @dinner = current_user.meals.where(meal_type: 'dinner')
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
        origin = current_user.meals.find(params[:id])
        @meal = origin.dup
        @meal.save
        @meal.update(meal_type: params[:meal_type])
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
