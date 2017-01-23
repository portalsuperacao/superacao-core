class RemoveNameFromParticipant < ActiveRecord::Migration[5.0]
  def change
    remove_column :participants, :name, :string
  end
end
