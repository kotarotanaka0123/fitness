class Group < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users
    validates :name, presence: true, uniqueness: true
    accepts_nested_attributes_for :group_users

    has_many :add_user_to_group, dependent: :destroy
    has_many :inviting_users, through: :add_user_to_group, source: :user

    mount_uploader :image, ImageUploader
    
    def show_last_message
        if (last_message = messages.last).present?
            last_message.content? ? last_message.content : '画像が投稿されています' 
        else
            'まだメッセージはありません。'
        end
    end

    def get_owner_name
        User.find(self.owner_id).name
    end
end
