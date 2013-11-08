class RefereesController < ApplicationController
   #restrict access
   before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update]
   
   def index
      @referees = Referee.all
   end
   
   def new
      @referee = current_user.referees.build
   end
   
   def create
      @referee = current_user.referees.build(acceptable_params)
      if @referee.save
         flash[:success] = "Referee created!"
         redirect_to @referee
      else
         flash.now[:danger] = "Unable to create referee"
         render :new
      end
   end
   
   def show
      if (Referee.exists?(params[:id]))
         @referee = Referee.find(params[:id])
      end
   end
   
   def edit
      if (Referee.exists?(params[:id]))
         @referee = Referee.find(params[:id])
      end
   end
   
   private
      def acceptable_params
         params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)   
      end
   
      def ensure_user_logged_in
         if (!logged_in?)
            flash[:warning] = "Unable"
            redirect_to login_path
         end
      end
end