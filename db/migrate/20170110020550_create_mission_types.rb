class CreateMissionTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :mission_types do |t|
      t.string :name
      
      t.integer :deadline
      t.json :guidance
    end
  end
end
