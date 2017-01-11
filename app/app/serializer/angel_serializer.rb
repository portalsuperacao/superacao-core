class AngelSerializer < BaseSerializer
  attributes :name, :uid
  has_many :trinities
end
