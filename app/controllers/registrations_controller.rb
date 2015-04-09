class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def update_resource(resource, params)

    # Check if the user asked to update it's password
    if resource.encrypted_password.blank? # || params[:password].blank?
      resource.email = params[:email] if params[:email]
      if !params[:password].blank? && params[:password] == params[:password_confirmation]
        logger.info "Updating password"
        resource.password = params[:password]
        resource.save
      end
      if resource.valid?
        resource.update_without_password(params)
      end
    else
      resource.update_with_password(params)
    end
  end

  protected

  # Add new parameters to Devise (new user fields)
  # https://github.com/plataformatec/devise#strong-parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :birthdate, :origin_country, :phone)
    devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name, :birthdate, :origin_country, :phone)
  end  
end