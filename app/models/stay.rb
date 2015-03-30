class Stay < ActiveRecord::Base
	geocoded_by :full_street_address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	def new
		
	end

	def create
		
	end

	def show
		
	end
	
end
