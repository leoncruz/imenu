# frozen_string_literal: true

require 'application_system_test_case'

class DownloadRestaurantQrcodeTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  setup do
    @restaurant = Restaurant.new(
      name: 'Restaurant #1',
      email: 'admin@restaurant1.com',
      password: '123123'
    )
    @restaurant.save!

    perform_enqueued_jobs

    @restaurant.update(confirmed_at: Time.current)

    login_as(@restaurant)
  end

  test 'download the restaurant qrcode' do
    visit restaurant_path(@restaurant)

    click_on I18n.t('navbar.qrcodes')

    assert_css("img[src*='#{@restaurant.qrcode.filename}']")

    click_on I18n.t('helpers.actions.download')

    wait_for_download

    assert_equal 1, downloads.count

    assert_equal downloaded_file, @restaurant.qrcode.filename.to_s
  end
end
