class UsersController < ApplicationController 
   #Restrict access to some methods
   before_action :ensure_user_logged_in, only: [:edit, :update]
   before_action :ensure_correct_user, only: [:edit, :update]
   before_action :ensure_admin_user, only: [:destroy]
   
   def index
      @users = User.all
   end
   
   def show
      if (User.exists?(params[:id]))
         @user = User.find(params[:id])
      end
   end
   
   def new
      @user = User.new
   end
   
   def create
      @user = User.new(permitted_params)
      if @user.save
         flash[:success] = "Welcome to the site: #{@user.username}"
         redirect_to @user
      else
         render :new
      end
   end
   
   def edit
      if (User.exists?(params[:id]))
         @user = User.find(params[:id])
      end
   end
   
   def update
      if (User.exists?(params[:id]))
         @user = User.find(params[:id])
         if @user.update(permitted_params)
            redirect_to @user
         else
            render :edit
         end
      end
   end
   
   def destroy
      if (User.exists?(params[:id]))
         @user = User.find(params[:id])
         flash[:success] = "Deleted: #{@user.username}"
         @user.destroy
         redirect_to users_path
      end
   end
   
   private
   
      def permitted_params
         params.require(:user).permit(:username, :password, :password_confirmation, :email)
      end
      
      def ensure_user_logged_in
         if (!logged_in?)
            flash[:danger] = "You can't do that!"
            redirect_to login_path
         end
      end
      
      def ensure_correct_user
         if (User.exists?(params[:id]))
            @user = User.find(params[:id])
            if (!current_user?(@user))
               flash[:danger] = "You can't do that!"
               redirect_to root_path
            end
         end
      end
   
      def ensure_admin_user
         if (!current_user.admin?)
            flash[:danger] = "You can't do that!"
            redirect_to users_path
         end
      end
 end