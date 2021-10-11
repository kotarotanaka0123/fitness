class AddUserIdToTotal < ActiveRecord::Migration[5.2]
  def change
    add_reference :totals, :user, index: true
  end
end
