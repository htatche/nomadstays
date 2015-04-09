class OmniauthCallbacksController < Devise::OmniauthCallbacksController

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
      # If a user had already registered using this email, we just linked it up
      # to this identity

      @user_by_email = User.find_by_email @identity.email
      
      if @user_by_email
        @user = @user_by_email
      else
        full_name = @identity.build_name

        @user = User.new(
          email: @identity.email || @user_by_email || "",
          first_name: full_name[0],
          last_name: full_name[1],
          photo: @identity.image
        )
      end  

      @user.skip_confirmation! 
      @user.save
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