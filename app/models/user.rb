class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, #, :validatable
         :omniauthable, omniauth_providers: [:twitter, :google_oauth2]

  has_many :identities,           dependent: :delete_all
  has_many :stays,                dependent: :delete_all
  has_many :bookings,             dependent: :delete_all

  def twitter
    identities.where( provider: 'twitter' ).first
  end

  def google_oauth2
    identities.where( provider: 'google_oauth2' ).first
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_all_data
    email? &&
    first_name? &&
    last_name? &&
    birthdate? &&
    origin_country?
  end

end	                