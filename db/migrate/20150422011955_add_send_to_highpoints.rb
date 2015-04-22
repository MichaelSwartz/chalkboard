class AddSendToHighpoints < ActiveRecord::Migration
  def change
    add_column :highpoints, :send, :boolean
  end
end
