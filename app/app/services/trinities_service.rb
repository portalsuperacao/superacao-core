class TrinitiesService

  class << self
    def create_custom_match trinity
      trinity.save!
    end
  end
end
