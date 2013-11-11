class Referee < ActiveRecord::Base
   belongs_to :user
   has_many :contests
   has_many :matches, as: :manager
   
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:rules_url, presence: true, format: /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/)
   validates(:players_per_game, presence: true, :numericality => {:greater_than => 0, :less_than => 11 })
   
   def upload=(uploaded_file)
      if (uploaded_file.nil?)
         #no file
      else
         time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
         file_location = Rails.root.join('code', 'referees', Rails.env, time_no_spaces).to_s
         IO::copy_stream(uploaded_file, file_location)         
      end
      self.file_location = file_location
   end
end