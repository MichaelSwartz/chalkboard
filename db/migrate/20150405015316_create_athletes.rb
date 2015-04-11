class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth, null: false
      t.string :gender, null: false
      t.string :team
      t.string :id_number

      t.timestamps
    end
  end
end
