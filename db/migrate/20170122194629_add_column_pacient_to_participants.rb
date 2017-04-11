class AddColumnPacientToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :pacient, :integer
    add_column :participants, :cancer_status, :integer

    remove_column :participants, :name, :string
  end
end
