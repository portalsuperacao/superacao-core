class AddColumnsParticipantProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :participant_profiles, :genre, :integer
    add_column :participant_profiles, :email, :string
    add_column :participant_profiles, :belief, :string
  end
end
