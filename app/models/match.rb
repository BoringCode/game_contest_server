class Match < ActiveRecord::Base
   belongs_to :manager, polymorphic: true
   belongs_to :contest
   belongs_to :referee
   has_many :player_matches
   has_many :players, through: :player_matches
   
   validates :manager, presence: true
   validates :status, presence: true
   validates :earliest_start, presence: true, allow_blank: true
   validates :earliest_start, timeliness: { type: :date, on_or_after: Time.current }, if: :waiting?
   validates :completion, presence: true
   validates :completion, timeliness: { type: :date, on_or_before: Time.current }, if: :completed?
   
   validate :number_of_players
   
   def number_of_players
      if (manager)
         if (players.count != manager.referee.players_per_game)
            errors.add('players.count', "Must equal " + manager.referee.players_per_game.to_s)
         end
      end
   end   
   def completed?
      self.status.downcase == "completed"
   end   
   def waiting?
      self.status.downcase == "waiting"
   end
end
