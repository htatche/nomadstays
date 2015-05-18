class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :stay

  validates :date_from,                          presence: true, allow_blank: false
  validates :date_to,                            presence: true, allow_blank: false
  validates :stay_length_in_months,              presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # validates_presence_of  :paid

  validates :date_from, :date_to, :overlap => {:scope => "stay_id",  :message => "This period is already booked, choose another one", :message_title => "This period is already booked, choose another one", :message_content => "This period is already booked, choose another one"}

  def total
    stay_length_in_months * (stay.monthly_price + extra_services_monthly_total)
  end

  def extra_services_monthly_total
    total = 0

    if service_pickup
      total += stay.service_pickup_price
    end

    if service_laundry
      total += stay.service_laundry_price
    end

    if service_cleaning
      total += stay.service_cleaning_price
    end

    if service_sim_card
      total += stay.service_sim_card_price
    end

    total
  end

end