class AddAvatarColumnsToParticipants < ActiveRecord::Migration[5.0]
  def change
     add_attachment :participants, :avatar
  end
end
