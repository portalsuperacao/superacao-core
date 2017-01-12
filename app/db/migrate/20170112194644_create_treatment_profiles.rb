class CreateTreatmentProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :treatment_profiles do |t|
      t.integer :pacient
      t.belongs_to :participant
      
      t.timestamps
    end
  end
end
