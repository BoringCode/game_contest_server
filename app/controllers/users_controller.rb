class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
        @user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
        @user.save
	end
end