class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter, :google_oauth2]

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
	  	user.provider = auth.provider
	  	user.uid			= auth.uid
	    user.username = auth.info.nickname
	    user.encrypted_password = Devise.friendly_token[0,20]
	    # user.first_name = auth.info.name   # assuming the user model has a name
	    user.photo = auth.info.image # assuming the user model has an image
	  end
	end  

def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(first_name: data["name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
        )
    end
    user
end	                

end
