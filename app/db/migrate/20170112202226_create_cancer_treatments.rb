class CreateCancerTreatments < ActiveRecord::Migration[5.0]
  def change
    create_table :cancer_treatments do |t|
      t.belongs_to :cancer_type
      t.references :cancerous, polymorphic: true, index: true
      t.timestamps
    end
  end
end
