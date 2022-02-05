class IngredientsController < ApplicationController
    # before_action :current_user
    before_action :set_q, only: [:search, :search_result]
    before_action :back_to_configBody
    before_action :back_to_configCalorie
    
    def index
        @ingredients = current_user.ingredients.all
    end

    def show
    end

    def search
        @results = @q.result
    end

    def search_result
        return @results = [] if params[:q][:name_cont].blank?
        @results = @q.result
    end

    def select
        if params[:format]
            @meal = current_user.meals.find(params[:format])
        else
            @meal = current_user.meals.new
        end
        @ingredients = current_user.ingredients.all
    end

    def show_info
        @ingredient = Ingredient.find(params[:data].to_i)
        @columns = [@ingredient.calc_calorie, @ingredient.Na, @ingredient.fat,
                    @ingredient.K, @ingredient.carbon, @ingredient.fiber,
                    @ingredient.protein, @ingredient.niacin, @ingredient.panto,
                    @ingredient.biotin, @ingredient.yosan, @ingredient.Ca,
                    @ingredient.Mg, @ingredient.Fe, @ingredient.P,
                    @ingredient.Zn, @ingredient.Cu, @ingredient.Mn,
                    @ingredient.vA, @ingredient.vE, @ingredient.vB1,
                    @ingredient.vB6, @ingredient.vB2
                    ]               
        gon.columns = [@ingredient.calc_calorie, @ingredient.Na, @ingredient.fat,
                        @ingredient.K, @ingredient.carbon, @ingredient.fiber,
                        @ingredient.protein, @ingredient.niacin, @ingredient.panto,
                        @ingredient.biotin, @ingredient.yosan, @ingredient.Ca,
                        @ingredient.Mg, @ingredient.Fe, @ingredient.P,
                        @ingredient.Zn, @ingredient.Cu, @ingredient.Mn,
                        @ingredient.vA, @ingredient.vE, @ingredient.vB1,
                        @ingredient.vB6, @ingredient.vB2
                    ] 
    end

    def addToMeal
        @meal = current_user.meals.new
        @ingredient = Ingredient.find(params[:id])
        @meal.save
        @meal.update(food_id: params[:id])
        # 材料レコードに食事を紐付ける。
        @ingredient.update(meal_id: @meal.id)
        @meal.protein = @ingredient.protein
    end

    def search
        @results = @q.result
    end

    private

    def set_q
        @q = Ingredient.ransack(params[:q])
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
