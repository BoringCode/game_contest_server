class RefereesController < ApplicationController
   #restrict access
   before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
   before_action :ensure_contest_creator, only: [:new, :create, :edit, :update]
   before_action :ensure_correct_user, only: [:update, :edit, :destroy]
   
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
         File.delete(@referee.file_location)
         @referee.destroy
         redirect_to referees_path
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
      def ensure_contest_creator
         if (!current_user.contest_creator?)
            flash[:danger] = "Unable"
            redirect_to root_path
         end
      end  
      def ensure_correct_user
         if (Referee.exists?(params[:id]))
            @referee = Referee.find(params[:id])
            if (!current_user?(@referee.user))
               flash[:danger] = "Unable"
               redirect_to root_path
            end
         end
      end
end