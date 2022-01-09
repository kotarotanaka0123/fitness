class AddDescribeToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :describe, :text
  end
end
