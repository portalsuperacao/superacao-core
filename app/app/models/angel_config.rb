# == Schema Information
#
# Table name: angel_configs
#
#  id                   :integer          not null, primary key
#  supported_overcomers :integer
#  welcome_message      :text
#  angel_id             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class AngelConfig < ApplicationRecord
  belongs_to :angel

  MAX_OVERCOMERS = Rails.configuration.superacao['angel_max_overcomers']

  after_initialize do
    self.supported_overcomers = MAX_OVERCOMERS if self.new_record?
  end
end
