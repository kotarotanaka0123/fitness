class Goal < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :slim
    validates :deadline
  end

  validate :not_before_today
  
  def not_before_today
    errors.add(:deadline, "明日以降の日付を入力してください") if deadline.nil? || deadline <= startday
  end
end
