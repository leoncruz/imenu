# frozen_string_literal: true

require 'test_helper'

class QrcodeGeneratableTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test 'create a qrcode after create a restaurant' do
    new_restaurant = Restaurant.new(
      name: 'Restaurant #1',
      email: 'admin@restaurant1.com',
      password: '123123'
    )

    assert_not new_restaurant.qrcode.attached?

    assert_difference ['ActiveStorage::Blob.count', 'ActiveStorage::Attachment.count'] do
      perform_enqueued_jobs { new_restaurant.save! }
    end

    assert_predicate new_restaurant.reload.qrcode, :attached?
  end
end
