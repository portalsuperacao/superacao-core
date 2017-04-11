class Api::V1::PositiveMessageSerializer < BaseSerializer
  attributes :name, :category, :image_thumb, :image_large

  def image_thumb
    object.image.url(:thumb)
  end

  def image_large
    object.image.url(:large)
  end
end
