# frozen_string_literal: true

class RestaurantsController < ApplicationController
  skip_before_action :authenticate_restaurant!

  before_action :set_restaurant

  def show; end

  private

  def set_restaurant
    @restaurant = Restaurant.includes(menu: { categories: :items }).find_by!(slug: params[:slug])
  end
end
