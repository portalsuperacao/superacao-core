class ArchangelSerializer < BaseSerializer
  attributes :name, :uid
  has_many :trinities
end
