class CreateTempUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_users do |t|
      t.string :mail_address, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :token, limit: 64, null: false
      t.datetime :expired_at, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false    
      t.index :mail_address, name: "index_temp_users_on_mail_address", unique: true
      t.index :token, name: "index_temp_users_on_token", unique: true
      
      t.timestamps
    end
  end
end
