class Ingredient < ApplicationRecord
    has_many :meal_ingredients
    has_many :meals, through: :meal_ingredients

    def calc_calorie
        self.protein*4 + self.fat*9 + self.carbon*4
    end
end
