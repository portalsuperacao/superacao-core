class AddColumnsToTreatmentProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :treatment_profiles, :metastasis, :boolean
    add_column :treatment_profiles, :relapse, :boolean
  end
end
