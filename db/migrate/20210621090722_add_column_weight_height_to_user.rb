class AddColumnWeightHeightToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :weight, :float 
    add_column :users, :height, :float
    add_column :users, :age, :integer
  end
end
