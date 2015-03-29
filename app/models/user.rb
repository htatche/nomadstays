class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :omniauthable, :omniauth_providers => [:twitter]
         # :validatable,

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

end
