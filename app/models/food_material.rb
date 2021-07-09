class FoodMaterial < ApplicationRecord
  belongs_to :food
  belongs_to :materials
end
