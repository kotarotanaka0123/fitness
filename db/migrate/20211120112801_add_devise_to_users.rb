# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.2]
  def change
      ## Database authenticatable
      add_column :users, :encrypted_password, :string, null: false, default: ""

      ## Recoverable
      add_column :users, :reset_password_token, :string
      add_column :users, :reset_password_sent_at, :datetime

      ## Rememberable
      add_column :users, :remember_created_at, :datetime

      ## Trackable
      add_column :users, :sign_in_count, :integer, default: 0, null: false 
      add_column :users, :current_sign_in_at, :datetime
      add_column :users, :last_sign_in_at, :datetime
      add_column :users, :current_sign_in_ip, :inet
      add_column :users, :last_sign_in_ip, :inet

      ## Confirmable
      add_column :users, :confirmation_token, :string
      add_column :users, :confirmed_at, :datetime
      add_column :users, :confirmation_sent_at, :datetime
      add_column :users, :unconfirmed_email, :string

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at   


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end

  # def self.down
  #   # By default, we don't want to make any assumption about how to roll back a migration when your
  #   # model already existed. Please edit below which fields you would like to remove in this migration.
  #   # raise ActiveRecord::IrreversibleMigration
  # end
end
