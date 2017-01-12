class CreateMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
    t.belongs_to :mission_type
    t.belongs_to :trinity
    t.belongs_to :participant
    t.string :status, null: false, default: "new"

    t.timestamps
    end
  end
end
