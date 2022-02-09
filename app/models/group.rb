class Group < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users
    validates :name, presence: true, uniqueness: true
    accepts_nested_attributes_for :group_users

    mount_uploader :image, ImageUploader
    
    def show_last_message
        if (last_message = messages.last).present?
            last_message.content? ? last_message.content : '画像が投稿されています' 
        else
            'まだメッセージはありません。'
        end
    end
end
