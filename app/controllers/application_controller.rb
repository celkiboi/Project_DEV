class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_devise_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_last_seen_at, if: :user_signed_in?
  before_action :set_user_country, if: :user_signed_in?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :lastname ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :lastname, :blocked, :password, :password_confirmation, :profile_picture, :current_password, contact_emails_attributes: [ :id, :email, :_destroy ] ])
  end

  private

    def set_devise_locale
      I18n.locale = :hr
    end

    def update_last_seen_at
      current_user.update_column(:last_seen_at, Time.current)
    end

    def set_user_country
      if current_user.country.blank?
        ip = request.remote_ip
        country = IpstackService.new(ip).fetch_country
        current_user.update(country: country) if country.present?
      end
    end
end
