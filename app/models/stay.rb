class Stay < ActiveRecord::Base
  belongs_to :user

  has_one  :apartment,    :dependent => :destroy
  has_one  :house,        :dependent => :destroy

  # has_many :rooms #, through: :apartment
  # has_many :rooms #, through: :house
  has_many :rooms,                dependent: :delete_all
  has_many :bookings,             dependent: :delete_all
  has_many :stay_photos,          dependent: :delete_all

  accepts_nested_attributes_for :stay_photos
  accepts_nested_attributes_for :apartment
  accepts_nested_attributes_for :house

  geocoded_by :full_address          # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  validates_presence_of       :title
  validates_presence_of       :description

  validates :accomodation_type, presence: true, allow_blank: false

  validates_presence_of       :street_address
  validates_presence_of       :country_code
  validates_presence_of       :country_name
  validates_presence_of       :city
  validates_presence_of       :full_address

  validates_presence_of       :latitude
  validates_presence_of       :longitude


  validates_inclusion_of :wifi,                             in: [true, false]
  validates_inclusion_of :mobile_data,                      in: [true, false]

  validates_inclusion_of :terrace,                          in: [true, false]
  validates_inclusion_of :router_access,                    in: [true, false]
  validates_inclusion_of :desk,                             in: [true, false]

  validates_inclusion_of :service_pickup,                   in: [true, false]
  validates_inclusion_of :service_laundry,                  in: [true, false]
  validates_inclusion_of :service_cleaning,                 in: [true, false]
  validates_inclusion_of :service_sim_card,                 in: [true, false]

  validates :service_pickup_price,    allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :service_laundry_price,   allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :service_cleaning_price,  allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :service_sim_card_price,  allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # validates_inclusion_of :available,                        in: [true, false]

  validates :monthly_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def attached_rooms
    container = apartment || house
    container.rooms
  end

  def build_full_address
    if state
      full_address = street_address + ", " + city + ", " + state + ", " + country_name
    else
      full_address = street_address + ", " + city + ", " + country_name
    end
  end

  # Get all the bookings for this stay, so we can
  # render the availability calendar
  def booked_dates
    dates = []

    bookings.each { |booking|
      from = booking.date_from.strftime("%d/%m/%Y") 
      to   = booking.date_to.strftime("%d/%m/%Y")

      dates << [from, to]
    }

    dates
  end

  def offers_extra_services?
    service_pickup || service_cleaning || service_laundry || service_sim_card
  end

  def pending_bookings
    bookings.where( status: 'pending' )
  end

  def pending_payment_bookings
    bookings.where( status: 'accepted', paid: 'false' )
  end

  def ready_bookings
    bookings.where( status: 'ready', paid: 'true' )
  end

  def cover_photo
    stay_photos.where( cover: true ).first
  end

  # def get_country_name
  #   debugger

  #   country = ISO3166::Country[country]
  #   # country.translations[I18n.locale.to_s] || country.name
  #   country.name
  # end  

end