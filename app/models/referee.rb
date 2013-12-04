class Referee < ActiveRecord::Base
   belongs_to :user
   has_many :contests
   has_many :matches, as: :manager
   
   validates(:name, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:rules_url, presence: true, format: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/i)
   validates(:players_per_game, presence: true, :numericality => { :only_integer => true, :greater_than => 0, :less_than => 11 })
   include Uploadable
   
   def referee
      self
   end
end
