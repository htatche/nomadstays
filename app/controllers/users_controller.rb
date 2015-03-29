class UsersController < ApplicationController
	before_action :authenticate_user!
	user_signed_in?

end