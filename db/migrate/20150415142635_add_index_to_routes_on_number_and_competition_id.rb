class AddIndexToRoutesOnNumberAndCompetitionId < ActiveRecord::Migration
  def change
    add_index :rounds, [:competition_id, :name], unique: true
    add_index :rounds, [:competition_id, :number], unique: true
    add_index :routes, [:round_id, :name], unique: true
  end
end
