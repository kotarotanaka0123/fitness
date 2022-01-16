class AddDescriptionToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :description, :string, unique: true
  end
end
