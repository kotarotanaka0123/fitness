class CreateTempUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_users do |t|
    
      t.timestamps
    end
  end
end
