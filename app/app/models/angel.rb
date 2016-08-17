class Angel < Participant
  has_many :trinities
  has_many :angels, through: :trinity

  MAX_OVERCOMERS = 3 
end
