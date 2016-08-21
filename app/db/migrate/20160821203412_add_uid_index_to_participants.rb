class AddUidIndexToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_index :participants, :part_number
  end
end
