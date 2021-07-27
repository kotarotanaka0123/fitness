class IngredientsController < ApplicationController
    before_action :current_user
    def index
        @ingredients = current_user.ingredients.all
        @breakfast = 
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
        @food = current_user.foods.find(params[:id])
        @meal = Meal.new
        @f = @meal.foods.new
    end

    def update
        @food = current_user.foods.find(params[:id])
        @food.update!(food_params)
    end

    def destroy
        @food = current_user.foods.find(params[:id])
        @food.destroy
    end

    private

    def food_params
        params.require(:food).permit!
    end
end
