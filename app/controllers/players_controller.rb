class PlayersController < ApplicationController   
   #restrict access
   before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
   before_action :ensure_correct_user, only: [:update, :edit, :destroy]
   
   def index
      if (Contest.exists?(params[:contest_id]))
         @contest = Contest.find(params[:contest_id])
         @players = @contest.players
      end
   end
   
   def new
      if (Contest.exists?(params[:contest_id]))
         contest = Contest.find(params[:contest_id])
         @player = contest.players.build
      end
   end
   
   def create
      if (Contest.exists?(params[:contest_id]))
         contest = Contest.find(params[:contest_id])
         @player = contest.players.build(permitted_params)
         @player.user = current_user
         if @player.save
            flash[:success] = "Player created"
            redirect_to @player
         else
            flash.now[:danger] = "Unable to create player"
            render :new
         end
      end
   end
   
   def update
      if (Player.exists?(params[:id]))
         @player = Player.find(params[:id])
         if @player.update(permitted_params)
            flash[:success] = "Updated: #{@player.name}"
            redirect_to @player
         else
            flash.now[:danger] = "Unable to update #{@player.name}"
            render :edit
         end
      end
   end
   
   def show
      if (Player.exists?(params[:id]))
         @player = Player.find(params[:id])
      end
   end
   
   def edit
      if (Player.exists?(params[:id]))
         @player = Player.find(params[:id])
      end
   end
   
   def destroy
      if (Player.exists?(params[:id]))
         @player = Player.find(params[:id])
         flash[:success] = "Deleted: #{@player.name}"
         File.delete(@player.file_location)
         @player.destroy
         redirect_to contest_players_path(@player.contest)
      end
   end
   
   private
      def permitted_params
          params.require(:player).permit(:name, :description, :downloadable, :playable, :contest_id, :user_id, :upload)  
      end   
      def ensure_user_logged_in
         if (!logged_in?)
            flash[:warning] = "Unable"
            redirect_to login_path
         end
      end   
      def ensure_correct_user
         if (Player.exists?(params[:id]))
            @player = Player.find(params[:id])
            if (!current_user?(@player.user))
               flash[:danger] = "Unable"
               redirect_to root_path
            end
         end
      end
end
