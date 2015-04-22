class RemoveUniqueIndexFromBibsOnNumber < ActiveRecord::Migration
  def up
    remove_index :bibs, [:number, :competition_id]
  end
  def down
    add_index :bibs, [:number, :competition_id], unique: true
  end
end
