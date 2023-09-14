# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_restaurant!, only: :index

  def index; end
end
