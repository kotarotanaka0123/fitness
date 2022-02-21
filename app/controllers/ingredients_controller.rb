class IngredientsController < ApplicationController
    before_action :set_q, only: [:search, :search_result]
    
    def index
        @ingredients = current_user.ingredients.all
    end

    def new
        @ingredient = current_user.ingredients.new
    end

    def create
        @ingredient = current_user.ingredients.new(ing_params)
        
        redirect_to ingredient_path(@ingredient) and return if @ingredient.save
    end

    def show
        @ingredient = Ingredient.find(params[:id])
        @ingredients = current_user.ingredients.all
    end

    def search
        @results = @q.result
    end

    def search_result
        return @results = [] if params[:q][:name_cont].blank?
        @results = @q.result
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
        return if params[:ingredients_ids].nil?

        protein = 0
        carbon = 0
        fat = 0
        # NOTE: 選択した材料の栄養素を合計する。
        params[:ingredients_ids].each do |index, value|
            ingredient = Ingredient.find(value[0])
            # NOTE: 個数分計算
            for num in 1..value[1].to_i do
                protein += ingredient.protein
                carbon += ingredient.carbon
                fat += ingredient.fat
            end
        end
        render json: {
            protein: protein,
            carbon: carbon,
            fat: fat
        }
    end

    def search
        @results = @q.result
    end

    private

    def set_q
        @q = Ingredient.ransack(params[:q])
    end

    def ing_params
        params.require(:ingredient).permit(:name, :description, :carbon, :protein, :fat)
    end
end