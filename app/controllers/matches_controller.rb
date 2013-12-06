class MatchesController < ApplicationController
   def show
      if (Match.exists?(params[:id]))
         @match = Match.find(params[:id])
      end
   end
   
   def index
      if (Contest.exists?(params[:contest_id]))
         @contest = Contest.find(params[:contest_id])
         @matches = @contest.matches
      end
   end
end
