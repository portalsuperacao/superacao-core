class CreateActivationCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :activation_codes do |t|
      t.string :code
      t.boolean :activated
      t.date :activated_at
      t.belongs_to :participant

      t.timestamps
    end
  end
end
