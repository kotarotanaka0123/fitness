class User < ApplicationRecord
    has_secure_password
    has_one :goal, dependent: :destroy
    has_many :meals
    has_many :ingredients
end
