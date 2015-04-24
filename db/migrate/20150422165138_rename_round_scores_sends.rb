class RenameRoundScoresSends < ActiveRecord::Migration
  def change
    rename_column :round_scores, :sends, :tops
  end
end
