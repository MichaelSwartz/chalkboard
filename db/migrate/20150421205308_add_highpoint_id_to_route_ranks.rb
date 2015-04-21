class AddHighpointIdToRouteRanks < ActiveRecord::Migration
  def change
    add_column :route_ranks, :highpoint_id, :integer, null: false
  end
end
