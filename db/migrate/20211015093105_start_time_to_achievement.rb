class StartTimeToAchievement < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :start_time, :datetime
  end
end
