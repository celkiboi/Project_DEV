class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_devise_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :lastname, :blocked, :password, :password_confirmation, :profile_picture, :current_password, contact_emails_attributes: [:id, :email, :_destroy]])
  end

  private

    def set_devise_locale
      I18n.locale = :hr
    end
end
