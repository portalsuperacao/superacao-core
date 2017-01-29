class ChangeColumnActivatedAtOnActivationCode < ActiveRecord::Migration[5.0]
  def change
    change_column :activation_codes, :activated_at, :datetime
  end
end
