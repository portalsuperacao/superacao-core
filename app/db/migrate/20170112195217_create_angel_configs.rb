class CreateAngelConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :angel_configs do |t|
      t.integer :supported_overcomers
      t.text :welcome_message
      t.belongs_to :angel

      t.timestamps
    end
  end
end
