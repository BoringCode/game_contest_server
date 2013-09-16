class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		/do nothing/
	end
end