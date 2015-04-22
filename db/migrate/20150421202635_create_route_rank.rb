class CreateRouteRank < ActiveRecord::Migration
  def change
    create_table :route_ranks do |t|
      t.integer :route_id, null: false
      t.integer :athlete_id, null: false
      t.float :rank, null: false
    end

    add_index :route_ranks, [:route_id, :athlete_id], unique: true
  end
end
