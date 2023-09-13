# frozen_string_literal: true

class QrcodeGenerator < ApplicationJob
  def perform(restaurant)
    restaurant.generate_qrcode
  end
end
