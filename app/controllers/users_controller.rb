class UsersController < ApplicationController
	# before_action :authenticate_user!

	def profile
		user_signed_in?

	end


end