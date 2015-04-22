class CreateRoundScores < ActiveRecord::Migration
  def change
    create_table :round_scores do |t|
      t.integer :athlete_id, null: false
      t.integer :round_id, null: false
      t.float :score, null: false
      t.integer :sends, null: false
    end

    add_index :round_scores, [:round_id, :athlete_id], unique: true
  end
end
