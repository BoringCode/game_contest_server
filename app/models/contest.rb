class Contest < ActiveRecord::Base
   belongs_to :user
   belongs_to :referee
   has_many :players
   has_many :matches, as: :manager
   
   validates(:referee, presence: true)
   validates(:user, presence: true)
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:contest_type, presence: true)
   validates(:deadline, presence: true, :timeliness => {:on_or_before => :start, :on_or_after => Time.current, :type => :datetime})
   validates(:start, presence: true, :timeliness => {:on_or_after => :deadline, :type => :datetime})
   validates(:description, presence: true)
end
