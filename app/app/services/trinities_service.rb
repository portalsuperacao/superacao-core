class TrinitiesService

  class << self
    def create_manual_match trinity
      Trinity.where(overcomer: overcomer_id, status: active)

    end
  end
end
