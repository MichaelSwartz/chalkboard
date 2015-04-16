class RemoveNumberFromAttempts < ActiveRecord::Migration
  def up
    remove_column :attempts, :number
  end
  def down
    add_column :attempts, :number, :integer
  end
end
