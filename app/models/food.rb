class Food < ApplicationRecord
    belongs_to :user
    has_many :food_materials
    has_many :materials, through: :food_materials
end
