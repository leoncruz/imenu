# frozen_string_literal: true

module Restaurant::QrcodeGeneratable
  extend ActiveSupport::Concern

  included do
    has_one_attached :qrcode, dependent: :destroy

    after_create_commit :enqueue_qrcode_generator
  end

  def generate_qrcode
    url = Rails.application.routes.url_helpers.restaurant_url(self)

    code = RQRCode::QRCode.new(url)

    png = code.as_png(fill: ChunkyPNG::Color::TRANSPARENT)

    qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: 'qrcode.png',
      content_type: 'image/png'
    )
  end

  private

  def enqueue_qrcode_generator
    QrcodeGenerator.perform_later(self)
  end
end
