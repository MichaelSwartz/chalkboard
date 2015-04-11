class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name, null: false
      t.string :gender
      t.string :division
      t.integer :user_id, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.string :gym
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
