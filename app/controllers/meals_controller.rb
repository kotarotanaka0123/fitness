class MealsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_q, only: [:search, :search_result]

    def index
        @meals = current_user.meals.where(meal_type: nil).order(updated_at: :DESC).page(params[:page]).per(5)


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

        createdtime = @total.created_at.year.to_s+"-"+@total.created_at.month.to_s+"-"+@total.created_at.day.to_s
        calorie = @total.protein*4+@total.fat*9+@total.carbon*4
        today_achievement = current_user.achievements.where(latest_time: createdtime)
        # カレントユーザにおける、本日分の実績が既にある場合
        if today_achievement.present?
            today_achievement.update(calorie: calorie)
        else
            today_achievement = current_user.achievements.new(calorie: calorie, latest_time: createdtime)
            if !today_achievement.save
                flash.now[:error] = "実績に反映できません" 
                render :index
            end
        end

        # javascript用
        gon.total = @total
        gon.user = current_user
        gon.bmr = BMR.new(gon.user).calc_bmr
    end

    def new
        @meal = current_user.meals.new
        @ingredients = current_user.ingredients.all
    end

    def create
        @meal = current_user.meals.new(meal_params)
        if @meal.save
            redirect_to meals_path
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
        return redirect_to meals_path if params[:meal_type].blank?
        # NOTE: 他の人が作成した食事を摂取
        if params[:others]
            origin = Meal.find(params[:id])
            @meal = origin.dup
            @meal.save
            @meal.update(meal_type: params[:meal_type], user_id: current_user.id)
        else
            origin = current_user.meals.find(params[:id])
            @meal = origin.dup
            @meal.save
            @meal.update(meal_type: params[:meal_type])
        end

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

    def search
        @results = @q.result.where(meal_type: nil)
    end

    def search_result
        return @results = [] if params[:q][:name_cont].blank?
        @results = @q.result.where(meal_type: nil)
    end

    def show_info
        @meal = Meal.find(params[:data].to_i)
        @columns = [@meal.calc_calorie, @meal.Na, @meal.fat,
                    @meal.K, @meal.carbon, @meal.fiber,
                    @meal.protein, @meal.niacin, @meal.panto,
                    @meal.biotin, @meal.yosan, @meal.Ca,
                    @meal.Mg, @meal.Fe, @meal.P,
                    @meal.Zn, @meal.Cu, @meal.Mn,
                    @meal.vA, @meal.vE, @meal.vB1,
                    @meal.vB6, @meal.vB2]
    end

    def update_nutrition_score
        @meal = Meal.find(params[:meal_id].to_i)
        @count = params[:count].to_i
        @columns = [@meal.calc_calorie, @meal.Na, @meal.fat,
                    @meal.K, @meal.carbon, @meal.fiber,
                    @meal.protein, @meal.niacin, @meal.panto,     
                    @meal.biotin, @meal.yosan, @meal.Ca,
                    @meal.Mg, @meal.Fe, @meal.P,
                    @meal.Zn, @meal.Cu, @meal.Mn,
                    @meal.vA, @meal.vE, @meal.vB1,
                    @meal.vB6, @meal.vB2]
        respond_to do |format|
            format.json { render json: { 
                columns: @columns,
                count: @count
            }}
        end
    end

    private

    def meal_params
        params.require(:meal).permit!
    end

    def set_q
        @q = Meal.ransack(params[:q])
    end
end
