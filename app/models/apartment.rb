class Apartment < ActiveRecord::Base
	belongs_to :stay
	has_many :rooms
end
