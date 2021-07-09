class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.float :slim
      t.text :description
      t.date :deadline
      t.date :startday
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :goals, :slim
  end
end

