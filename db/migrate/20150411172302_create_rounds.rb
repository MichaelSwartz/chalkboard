class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :competition_id, null: false
    end
  end
end
