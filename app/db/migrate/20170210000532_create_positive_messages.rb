class CreatePositiveMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :positive_messages do |t|
      t.string :name
      t.attachment :image

      t.timestamps
    end
  end
end
