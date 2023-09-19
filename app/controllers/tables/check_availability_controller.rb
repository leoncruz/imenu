# frozen_string_literal: true

module Tables
  class CheckAvailabilityController < ApplicationController
    skip_before_action :authenticate_restaurant!

    def show
      restaurant = Restaurant.find_by!(slug: params[:restaurant_slug])

      table = restaurant.tables.find(params[:table_id])

      if table.available?
        cookies.signed[:table] = table.id

        redirect_to restaurant_path(restaurant)
      else
        redirect_to restaurant_path(restaurant), alert: t('.alert')
      end
    end
  end
end
