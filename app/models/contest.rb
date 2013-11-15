class Contest < ActiveRecord::Base
   belongs_to :user
   belongs_to :referee
   has_many :players
   has_many :matches, as: :manager
   
   validates(:referee, presence: true)
   validates(:user, presence: true)
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:contest_type, presence: true)
   validates(:start, presence: true, :timeliness => {:before => :deadline, :after => lambda { Date.today }, :type => :datetime})
   validates(:deadline, presence: true, :timeliness => {:after => :start, :type => :datetime})
   validates(:description, presence: true)
end
