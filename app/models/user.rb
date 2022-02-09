class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable
    
    validates :name, presence: true, uniqueness: true, on: :addingUsername
    with_options presence: true, numericality: {greater_than: 0}, if: :user_exists? do
        validates :weight
        validates :height
        validates :age
    end

    mount_uploader :image, ImageUploader

    has_one :goal, dependent: :destroy
    has_many :meals
    has_many :ingredients
    has_many :totals, dependent: :destroy
    has_many :achievements, dependent: :destroy
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

    has_many :add_user_to_group, dependent: :destroy
    has_many :inviting_users, through: :add_user_to_group, source: :user
    has_many :invited_groups, through: :add_user_to_group, source: :group
    
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

    def user_exists?
        self.persisted?
    end
end
