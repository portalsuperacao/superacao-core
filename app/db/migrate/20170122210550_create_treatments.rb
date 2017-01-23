class CreateTreatments < ActiveRecord::Migration[5.0]
  def change
    create_table :treatments do |t|
      t.integer :status
      t.belongs_to :treatment_type
      t.references :treatable, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
