class Message < ApplicationRecord
    belongs_to :group
    belongs_to :user

    # validates :content, presence: true, unless: :is_image?

    mount_uploader :image, ImageUploader

    # def is_image?
    #     binding.pry
    #     image.present?
    # end

end
