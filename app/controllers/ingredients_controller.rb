class IngredientsController < ApplicationController
    before_action :current_user
    
    def select
        if params[:format]
            @meal = current_user.meals.find(params[:format])
        else
            @meal = current_user.meals.new
        end
        @ingredients = Ingredient.all
    end

    def addToMeal
        @meal = current_user.meal.new
        @ingredient = Ingredient.find(params[:id])
        @meal.save
        @meal.update(food_id: params[:id])
        # フードレコードにミールを紐付ける。
        @ingredient.update(meal_id: @meal.id)
        @meal.protein = @ingredient.protein
    end
end

#     def index
#         @ingredients = current_user.ingredients.all
#         @breakfast = 
#     end

#     def new
#         @food = current_user.foods.new
#     end

#     def create
#         @food = current_user.foods.new(food_params)

#         if @food.save
#             redirect_to foods_path
#         else
#             render 'foods/new'
#         end
#     end

#     def addToMeal
#         @food = current_user.foods.find(params[:id])
#         @meal = Meal.new
#         @f = @meal.foods.new
#     end

#     def update
#         @food = current_user.foods.find(params[:id])
#         @food.update!(food_params)
#     end

#     def destroy
#         @food = current_user.foods.find(params[:id])
#         @food.destroy
#     end

#     private

#     def food_params
#         params.require(:food).permit!
#     end
# end
