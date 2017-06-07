class AddFamilyMemberToParticipant < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :family_member, :string
  end
end
