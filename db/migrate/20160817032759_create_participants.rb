class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :uid
      t.string :type

      t.timestamps
    end
  end
end
