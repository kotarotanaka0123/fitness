class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :protein, default: 0
      t.float :fat, default: 0
      t.float :carbon, default: 0
      t.float :fiber, default: 0
      t.float :vA, default: 0 
      t.float :vE, default: 0 
      t.float :vB1, default: 0 
      t.float :vB2, default: 0
      t.float :vB6, default: 0
      t.float :niacin, default: 0
      t.float :yosan, default: 0
      t.float :panto, default: 0
      t.float :biotin, default: 0
      t.float :Na, default: 0
      t.float :K, default: 0 
      t.float :Ca, default: 0 
      t.float :Mg, default: 0 
      t.float :P, default: 0 
      t.float :Fe, default: 0 
      t.float :Zn, default: 0 
      t.float :Cu, default: 0 
      t.float :Mn, default: 0 

      t.references :user
      
      t.timestamps
    end
  end
end
