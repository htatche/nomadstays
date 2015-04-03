class House < ActiveRecord::Base
	belongs_to :stay
	has_many :rooms

  validates_inclusion_of :garden, in: [true, false]
  validates_inclusion_of :terrace, in: [true, false]
  validates_inclusion_of :alarm, in: [true, false]

end
