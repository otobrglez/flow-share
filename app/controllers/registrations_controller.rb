class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]

  layout "base", only: [:edit]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password) }
  end

  def after_inactive_sign_up_path_for(resource)
    validate_email_path
  end

end
