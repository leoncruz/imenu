# frozen_string_literal: true

module QrcodeGeneratable
  extend ActiveSupport::Concern

  included do
    has_one_attached :qrcode, dependent: :purge_later

    after_create_commit :enqueue_qrcode_generator
  end

  def generate_qrcode
    code = RQRCode::QRCode.new(qrcode_url)

    png = code.as_png(fill: ChunkyPNG::Color::TRANSPARENT)

    qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: qrcode_filename || 'qrcode.png',
      content_type: 'image/png'
    )
  end

  private

  def qrcode_url
    raise NotImplementedError, 'must be implemented by inclued class'
  end

  def enqueue_qrcode_generator
    QrcodeGenerator.perform_later(self)
  end

  def qrcode_filename; end
end
