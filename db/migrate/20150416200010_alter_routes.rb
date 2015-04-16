class AlterRoutes < ActiveRecord::Migration
  def up
    remove_column :routes, :scored_holds
    change_column_null :routes, :max_score, false
  end
  def down
    add_column :routes, :scored_holds, :integer, null: false
    change_column_null :routes, :max_score, true
  end
end
