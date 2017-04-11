class CreateTrinities < ActiveRecord::Migration[5.0]
  def change
    create_table :trinities do |t|

      t.belongs_to :overcomer
      t.belongs_to :angel
      t.belongs_to :archangel

      t.timestamps
    end
  end
end
