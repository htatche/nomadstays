class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, #, :validatable, #:confirmable,
         :omniauthable, :omniauth_providers => [:twitter, :google_oauth2]

  has_many :identities,       :dependent => :delete_all
  has_many :stays,            :dependent => :delete_all

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def google_oauth2_client
    if !@google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
      @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
    end
    @google_oauth2_client
  end  

  def full_name
    first_name + " " + last_name
  end

	# def self.find_for_twitter_oauth2(auth)
 #    # Twitter doesnt provide First and Last name,
 #    # neither it gives an email

 #    full_name = build_name(auth.info.name)

	#   where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
	#   	user.provider = auth.provider
	#   	user.uid			= auth.uid
	#     user.username = auth.info.nickname
	#     user.first_name = full_name[0]
 #      user.last_name = full_name[1]
	#     user.photo = auth.info.image 
 #      user.encrypted_password = Devise.friendly_token[0,20]
	#   end
	# end  

 #  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
 #    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
 #      user.provider = auth.provider
 #      user.uid      = auth.uid   
 #      user.first_name = auth.info.first_name
 #      user.last_name = auth.info.last_name
 #      user.email = auth.info.email
 #      user.photo = auth.info.image
 #      user.encrypted_password = Devise.friendly_token[0,20]
 #    end
 #  end

end	                