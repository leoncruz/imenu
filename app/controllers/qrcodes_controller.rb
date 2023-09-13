# frozen_string_literal: true

class QrcodesController < ApplicationController
  before_action :set_restaurant

  def index
    @qrcode = @restaurant.qrcode
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find_by!(slug: params[:restaurant_slug])
  end
end
