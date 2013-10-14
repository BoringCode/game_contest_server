class UsersController < ApplicationController 
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
    if (User.exists?(params[:id]) && session[:user_id].to_s == params[:id].to_s)
      @user = User.find(params[:id])
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(permitted_params)
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    flash[:success] = "Deleted: #{@user.username}"
    @user.destroy
    redirect_to users_path
  end
  
  private
  
    def permitted_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end
end