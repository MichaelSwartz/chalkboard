class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name, null: false
      t.integer :round_id, null: false
      t.integer :scored_holds, null: false

      t.timestamps
    end
  end
end
