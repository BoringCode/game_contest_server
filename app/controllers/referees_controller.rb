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
      @referee = current_user.referees.build(permitted_params)
      if @referee.save
         flash[:success] = "Referee created!"
         redirect_to @referee
      else
         flash.now[:danger] = "Unable to create referee"
         render :new
      end
   end

   def update
      if (Referee.exists?(params[:id]))
         @referee = Referee.find(params[:id])
         if @referee.update(permitted_params)
            flash[:success] = "Updated: #{@referee.name}"
            redirect_to @referee
         else
            flash.now[:danger] = "Unable to update #{@referee.name}"
            render :edit
         end
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
   
   def destroy
      if (Referee.exists?(params[:id]))
         @referee = Referee.find(params[:id])
         flash[:success] = "Deleted: #{@referee.name}"
         @referee.destroy
         redirect_to root_path
      end
   end
   
   private
      def permitted_params
         params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)   
      end
   
      def ensure_user_logged_in
         if (!logged_in?)
            flash[:warning] = "Unable"
            redirect_to login_path
         end
      end
end