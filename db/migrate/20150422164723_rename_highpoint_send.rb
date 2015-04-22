class RenameHighpointSend < ActiveRecord::Migration
  def change
    rename_column :highpoints, :send, :top
  end
end
