class Player < ActiveRecord::Base
   belongs_to :user
   belongs_to :contest
   has_many :matches, through: :player_matches
   has_many :player_matches
   validates :user, presence: true
   validates :contest, presence: true
   
   validates(:name, presence: true, length: {maximum: 20})
   validates_uniqueness_of :name, :scope => :contest_id
   validates(:description, presence: true)
   #validates(:downloadable, presence: true)
   #validates(:playable, presence: true)
   
   include Uploadable
end
