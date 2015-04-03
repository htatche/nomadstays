class Room < ActiveRecord::Base
	belongs_to :house
	belongs_to :apartment

end
