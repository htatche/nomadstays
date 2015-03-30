class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def twitter
  #   @user = User.find_for_twitter_oauth2(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
  #   else
  #     # Hash returned by tweeter is too big to be stored in a cookie
  #     # session["devise.twitter_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def google_oauth2
  #     @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

  #     if @user.persisted?
  #       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
  #       sign_in_and_redirect @user, :event => :authentication
  #     else
  #       session["devise.google_data"] = request.env["omniauth.auth"]
  #       redirect_to new_user_registration_url
  #     end
  # end

  def twitter
    generic_callback( 'twitter' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end  

  def generic_callback( provider )
    @identity = Identity.find_for_oauth env["omniauth.auth"]

    @user = @identity.user || current_user
    if @user.nil?
      @user = User.create( email: @identity.email || "" )
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      @user = FormUser.find @user.id

      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

    
end