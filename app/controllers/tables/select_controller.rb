# frozen_string_literal: true

module Tables
  class SelectController < ApplicationController
    skip_before_action :authenticate_restaurant!
    before_action :set_restaurant

    respond_to :turbo_stream

    def index; end

    private

    def set_restaurant
      @restaurant = Restaurant.find_by!(slug: params[:restaurant_slug])
    end
  end
end
