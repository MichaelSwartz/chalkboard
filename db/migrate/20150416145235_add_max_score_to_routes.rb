class AddMaxScoreToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :max_score, :float
  end
end
