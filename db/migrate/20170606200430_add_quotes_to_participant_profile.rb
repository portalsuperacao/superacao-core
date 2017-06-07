class AddQuotesToParticipantProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :participant_profiles, :healing_quote, :text
    add_column :participant_profiles, :difficulty_quote, :string
  end
end
