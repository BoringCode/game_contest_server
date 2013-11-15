class Contest < ActiveRecord::Base
   belongs_to :user
   belongs_to :referee
   has_many :players
   has_many :matches, as: :manager
   validates :referee, presence: true
   validates :user, presence: true
   
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates :contest_type, presence: true
   validates_datetime :start, :before => :deadline, :after => lambda { Date.today }
   validates_datetime :deadline, :after => :start
   validates :description, presence: true     
end
