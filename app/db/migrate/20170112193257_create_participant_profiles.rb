class CreateParticipantProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :participant_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :occupation
      t.string :country
      t.string :state
      t.string :city
      t.decimal :lat
      t.decimal :lng
      t.string :relationship
      t.integer :sons
      t.string :facebook
      t.string :instagram
      t.string :whatsapp
      t.string :youtube
      t.string :snapchat

      t.belongs_to :participant

      t.timestamps
    end
  end
end
