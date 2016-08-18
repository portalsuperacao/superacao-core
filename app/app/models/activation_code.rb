class ActivationCode < ApplicationRecord
   belongs_to :participant

   validates :code, uniqueness: true

   before_validation :generate_code

   private
    def generate_code
        self.code = create_code

        while ActivationCode.find_by_code(self.code)
          self.code = create_code
        end
    end

    def create_code
      (0...8).map { (65 + rand(26)).chr }.join
    end
end
