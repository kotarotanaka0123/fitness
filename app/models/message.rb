class Message < ApplicationRecord
    belongs_to :group
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
    accepts_nested_attributes_for :user

    mount_uploader :image, ImageUploader

    validates :content, presence: true, unless: :is_image?

    def is_image?
        image.present?
    end
end
