class ContestsController < ApplicationController
   before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
   before_action :ensure_contest_creator, only: [:new, :create, :update, :edit]
   before_action :ensure_correct_user, only: [:update, :edit, :destroy]
   
   def index
      @contests = Contest.all
   end
   
   def new
      @contest = current_user.contests.build
   end
   
   def create
      @contest = current_user.contests.build(permitted_params)
      if @contest.save
         flash[:success] = "Contest created!"
         redirect_to @contest
      else
         flash.now[:danger] = "Unable to create contest"
         render :new
      end
   end
   
   def update
      if (Contest.exists?(params[:id]))
         @contest = Contest.find(params[:id])
         if @contest.update(permitted_params)
            flash[:success] = "Updated: #{@contest.name}"
            redirect_to @contest
         else
            flash.now[:danger] = "Unable to update #{@contest.name}"
            render :edit
         end
      end
   end
   
   def show
      if (Contest.exists?(params[:id]))
         @contest = Contest.find(params[:id])
      end
   end
   
   def edit
      if (Contest.exists?(params[:id]))
         @contest = Contest.find(params[:id])
      end
   end
   
   def destroy
      if (Contest.exists?(params[:id]))
         @contest = Contest.find(params[:id])
         flash[:success] = "Deleted: #{@contest.name}"
         @contest.destroy
         redirect_to contests_path
      end
   end
   
   private 
      def permitted_params
         params.require(:contest).permit(:name, :contest_type, :start, :deadline, :description, :referee_id)   
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
         if (Contest.exists?(params[:id]))
            @contest = Contest.find(params[:id])
            if (!current_user?(@contest.user))
               flash[:danger] = "Unable"
               redirect_to root_path
            end
         end
      end
end
