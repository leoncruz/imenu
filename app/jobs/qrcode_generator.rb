# frozen_string_literal: true

class QrcodeGenerator < ApplicationJob
  def perform(qrcode_generatable)
    qrcode_generatable.generate_qrcode
  end
end
