module Uploadable extend ActiveSupport::Concern
   included do
      validates :file_location, presence: true
      validate :validate_location
      def validate_location
         if (!self.file_location.nil? && !File.exist?(self.file_location))
            errors.add(:file_location, "File must exist")
         end
      end
   end
   def upload=(uploaded_file)
      if (uploaded_file.nil?)
         errors.add(:file_location, "Please upload a file")
         file_location = nil
      else
         file_name_time_hash = Time.now.to_s.gsub(/\s/, '_') + SecureRandom.hex(4)
         file_location = Rails.root.join('code', self.class.to_s.downcase.pluralize, Rails.env, file_name_time_hash).to_s
         IO::copy_stream(uploaded_file, file_location)
      end
      self.file_location = file_location
   end
end