# frozen_string_literal: true

class Table < ApplicationRecord
  include QrcodeGeneratable

  belongs_to :restaurant

  validates :code, presence: true, uniqueness: { scope: :restaurant }

  def available?
    # TODO
    true
  end

  private

  def qrcode_url
    Rails.application.routes.url_helpers.restaurant_table_check_availability_url(restaurant, self)
  end

  def qrcode_filename
    "qrcode-#{code}.png"
  end
end
