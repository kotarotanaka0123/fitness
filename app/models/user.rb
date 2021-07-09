class User < ApplicationRecord
    has_secure_password
    has_one :goal, dependent: :destroy
    has_many :foods
    has_many :materials
end
