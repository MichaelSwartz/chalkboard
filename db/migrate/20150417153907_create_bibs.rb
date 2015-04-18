class CreateBibs < ActiveRecord::Migration
  def change
    create_table :bibs do |t|
      t.string :number
      t.integer :athlete_id, null: false
      t.integer :competition_id, null: false
    end

    add_index :bibs, [:athlete_id, :competition_id], unique: true
    add_index :bibs, [:number, :competition_id], unique: true
  end
end
