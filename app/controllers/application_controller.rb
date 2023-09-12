# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionView::RecordIdentifier

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_restaurant!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    restaurant_path(resource)
  end
end
