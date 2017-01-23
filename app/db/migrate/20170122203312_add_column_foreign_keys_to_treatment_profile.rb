class AddColumnForeignKeysToTreatmentProfile < ActiveRecord::Migration[5.0]
  def change
    add_reference :treatment_profiles, :current_participant, index: true, foreign_key: {to_table: :participants}
    add_reference :treatment_profiles, :past_participant, index: true, foreign_key: {to_table: :participants}
  end
end
