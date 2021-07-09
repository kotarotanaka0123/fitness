class Material < ApplicationRecord
  belongs_to :user
  has_many :food_materials
  accepts_nested_attributes_for :food_materials
end
