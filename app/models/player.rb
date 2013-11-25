class Player < ActiveRecord::Base
   belongs_to :user
   belongs_to :contest
   has_many :matches, through: :player_matches
   has_many :player_matches
   validates :user, presence: true
   validates :contest, presence: true
   
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:description, presence: true)
   #validates(:downloadable, presence: true)
   #validates(:playable, presence: true)
   include Uploadable
end
