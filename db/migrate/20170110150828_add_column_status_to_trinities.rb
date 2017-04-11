class AddColumnStatusToTrinities < ActiveRecord::Migration[5.0]
  def change
    add_column :trinities, :status, :integer, default: 0
  end
end
