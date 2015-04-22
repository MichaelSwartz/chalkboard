class CreateHighpoints < ActiveRecord::Migration
  def change
    create_table :highpoints do |t|
      t.integer :route_id, null: false
      t.integer :athlete_id, null: false
      t.integer :attempt_id, null: false
    end

    add_index :highpoints, [:route_id, :athlete_id], unique: true
  end
end
