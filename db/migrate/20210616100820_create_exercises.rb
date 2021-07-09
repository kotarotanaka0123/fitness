class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :span
      t.float :calorie
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
