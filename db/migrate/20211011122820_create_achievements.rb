class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements do |t|
      t.float :today, default: 0.0
      t.float :past, default: 0.0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
