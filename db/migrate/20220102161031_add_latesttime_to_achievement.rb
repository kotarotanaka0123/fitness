class AddLatesttimeToAchievement < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :latest_time, :string
  end
end
