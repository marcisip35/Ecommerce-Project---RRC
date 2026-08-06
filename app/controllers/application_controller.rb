class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :allow_customer_information, if: :devise_controller?

  protected

  def allow_customer_information
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [ :username, :email ]
    )

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :username,
        :email,
        :first_name,
        :last_name,
        :street_address,
        :city,
        :postal_code,
        :province_id
      ]
    )
  end
end
