class PositiveMessage < ApplicationRecord
  enum uploaded: [:complete, :uncomplete]

  has_attached_file :image, styles: { large: "300x300>", thumb: "100x100>" },
                     path: ":rails_root/public/system/:class/:style/:hash.:extension",
                     hash_secret: SecureRandom.uuid,
                     default_url: "/images/image_not_found.png"
  validates_attachment :image, presence: true,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: { in: 0..1000.kilobytes }

  validates :name, :category, :image, presence: true

  before_save :check_storage_availability

  private
  def check_storage_availability
    return self.uploaded = :complete  if self.image.exists?(:large) and self.image.exists?(:thumb)
    self.uploaded = :uncomplete
  end
end
