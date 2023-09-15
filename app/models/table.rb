# frozen_string_literal: true

class Table < ApplicationRecord
  include QrcodeGeneratable

  belongs_to :restaurant

  validates :code, presence: true, uniqueness: { scope: :restaurant }

  private

  def qrcode_url
    Rails.application.routes.url_helpers.restaurant_url(restaurant, table: code)
  end

  def qrcode_filename
    "qrcode-#{code}.png"
  end
end
