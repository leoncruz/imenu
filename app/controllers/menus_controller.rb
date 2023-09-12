# frozen_string_literal: true

class MenusController < ApplicationController
  def edit
    @menu = Menu.find(params[:id])
  end
end
