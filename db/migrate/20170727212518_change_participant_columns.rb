class ChangeParticipantColumns < ActiveRecord::Migration[5.1]
  def change
    change_column :participants, :pacient, :string
    change_column :participants, :family_member, :string
    change_column :participants, :cancer_status, :string
    change_column :participant_profiles, :genre, :string
  end
end
