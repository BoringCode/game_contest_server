class Referee < ActiveRecord::Base
   belongs_to :user
   has_many :contests
   has_many :matches, as: :manager
   
   def upload=(uploaded_file)
      if (uploaded_file.nil?)
         #problem--no file
      else
         time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
         file_location = Rails.root.join('code', 'referees', current_user.id.to_s + time_no_spaces)
         uploaded_file.read
      end
      self.file_location = ""
   end
end
