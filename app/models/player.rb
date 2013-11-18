class Player < ActiveRecord::Base
   belongs_to :user
   belongs_to :contest
   has_many :matches, through: :player_matches
   has_many :player_matches
   validates :user, presence: true
   validates :contest, presence: true
   
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:file_location, presence: true)
   validates(:description, presence: true)
   #validates(:downloadable, presence: true)
   #validates(:playable, presence: true)
   
   validate :validate_location
   
   def validate_location
      if (!self.file_location.nil? && !File.exist?(self.file_location))
         errors.add(:file_location, "File must exist")
      end
   end
   
   def upload=(uploaded_file)
      if (uploaded_file.nil?)
         errors.add(:file_location, "Please upload a file")
         file_location = nil
      else
         file_name_time_hash = Time.now.to_s.gsub(/\s/, '_') + SecureRandom.hex(4)
         file_location = Rails.root.join('code', 'players', Rails.env, file_name_time_hash).to_s
         IO::copy_stream(uploaded_file, file_location)  
      end
      self.file_location = file_location
   end
end
