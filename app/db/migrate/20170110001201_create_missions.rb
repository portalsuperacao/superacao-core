class CreateMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
    t.belongs_to :mission_type,  name: 'mission_type_id'
    t.belongs_to :trinity,  name: 'trinity_id'
    t.string :status, null: false, default: "new"

    t.timestamps
    end
  end
end
