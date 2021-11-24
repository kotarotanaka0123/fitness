class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable
    has_one :goal, dependent: :destroy
    has_many :meals
    has_many :ingredients
    has_many :totals
    has_many :achievements
    has_many :products
    has_many :payments

    has_many :messages
    has_many :group_users, dependent: :destroy
    has_many :groups, through: :group_users

    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :followers, through: :reverse_of_relationships, source: :followed

    has_many :relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followings, through: :relationships, source: :follower

    has_many :likes, dependent: :destroy
    has_many :liked_messages, through: :likes, source: :message
    
    def follow(user_id)
        relationships.create(follower_id: user_id)
    end

    def unfollow(user_id)
        relationships.find_by(follower_id: user_id).destroy
    end

    def following?(user)
        followings.include?(user)
    end

    def already_liked?(message)
        self.likes.exists?(message_id: message.id)
    end
end
