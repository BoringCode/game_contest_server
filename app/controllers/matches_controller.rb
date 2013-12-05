class MatchesController < ApplicationController
   def show
      if (Match.exists?(params[:id]))
         @match = Match.find(params[:id])
      end
   end
   
   def index
      @matches = Match.all
   end
end
