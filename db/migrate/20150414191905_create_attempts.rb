class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :athlete_id, null: false
      t.integer :route_id, null: false
      t.float :score, null: false
      t.integer :number, null: false

      t.timestamps
    end

    add_index :attempts, [:athlete_id, :route_id, :number], unique: true
  end
end
