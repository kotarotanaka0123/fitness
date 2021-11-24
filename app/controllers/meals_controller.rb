class MealsController < ApplicationController
    before_action :current_user
    before_action :set_q, only: [:search]

    def index
        @meals = current_user.meals.where(meal_type: nil)

        @breakfast = current_user.meals.where(meal_type: 'breakfast')
        @lunch = current_user.meals.where(meal_type: 'lunch')
        @between = current_user.meals.where(meal_type: 'between')
        @dinner = current_user.meals.where(meal_type: 'dinner')

        absorbMeals = current_user.meals.where.not(meal_type: nil)
        @total = current_user.totals.new
        absorbMeals.each do |absorbMeal|
            @total.protein += absorbMeal.protein
            @total.fat += absorbMeal.fat
            @total.carbon += absorbMeal.carbon
        end
        @total.save
        if current_user.totals.count >= 2
            current_user.totals.order(created_at: "ASC").limit(1).destroy_all
        end

        @user = current_user

        # javascript用
        gon.total = @total
        gon.user = @user
        gon.bmr = BMR.new(gon.user).calc_bmr
    end

    def new
        @meal = current_user.meals.new
        @ingredients = Ingredient.all
    end

    def create
        @meal = current_user.meals.new(params.require(:meal).permit(:name))
        if @meal.save
            if params[:meal][:ingredient_ids].present?
                ingredientsId = params[:meal][:ingredient_ids].split(",").map(&:to_i)
                @ingredients = Ingredient.where(id: ingredientsId)
                @ingredients.each do |ingredient|
                    @meal.update({
                        protein: @meal.protein+ingredient.protein,
                        fat: @meal.fat+ingredient.fat,
                        carbon: @meal.carbon+ingredient.carbon
                    })
                end
                redirect_to meal_path(id: @meal.id)
            else
                @meal.update(meal_params)
                redirect_to meals_path
            end
        else
            redirect_to new_meal_path, notice: "名前を入力してください。"
        end
    end

    def show
        @meal = current_user.meals.find(params[:id])
        @ingredients = Ingredient.all
    end

    def update
        @meal = current_user.meals.find(params[:id])
        if params[:meal][:ingredient_ids].present?
            @ingredients = Ingredient.where(id: params[:meal][:ingredient_ids])
            @ingredients.each do |ingredient|
                @meal.update({
                    protein: @meal.protein+ingredient.protein,
                    fat: @meal.fat+ingredient.fat,
                    carbon: @meal.carbon+ingredient.carbon
                })
            end
            redirect_to meal_path(id: @meal.id)
        else
            @meal.update(meal_params)
            redirect_to meals_path
        end
    end

    def time
        origin = current_user.meals.find(params[:id])
        @meal = origin.dup
        @meal.save
        @meal.update(meal_type: params[:meal_type])

        redirect_to meals_path
    end

    def edit
        @meal = current_user.meals.find(params[:id])
        @ingredients = Ingredient.all
    end

    def destroy
        @meal = current_user.meals.find(params[:id])

        @meal.destroy
        redirect_to meals_path
    end

    def error
    end

    def search
        @results = @q.result.where(meal_type: nil)
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

    def set_q
        @q = Meal.ransack(params[:q])
    end
end
