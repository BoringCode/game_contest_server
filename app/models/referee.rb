class Referee < ActiveRecord::Base
   belongs_to :user
   has_many :contests
   has_many :matches, as: :manager
   
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:file_location, presence: true)
   validates(:rules_url, presence: true, format: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/i)
   validates(:players_per_game, presence: true, :numericality => { :only_integer => true, :greater_than => 0, :less_than => 11 })
   
   validate :validate_location
   
   def validate_location
      if (!self.file_location.nil? && !File.exist?(self.file_location))
         errors.add(:file_location, "File must exist")
      end
   end
   
   include Uploadable
end
