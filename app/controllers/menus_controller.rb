# frozen_string_literal: true

class MenusController < ApplicationController
  def new
    @menu = Menu.new(restaurant: current_restaurant)
  end

  def edit
    @menu = Menu.find(params[:id])
  end
end
