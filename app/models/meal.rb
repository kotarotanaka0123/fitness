class Meal < ApplicationRecord
    enum meal_type: { breakfast: 0, lunch: 1, between: 2, dinner: 3 }
    has_many :meal_ingredients, dependent: :destroy
    has_many :ingredients, through: :meal_ingredients
    accepts_nested_attributes_for :meal_ingredients

    belongs_to :user

    validates :name, presence: true
end
