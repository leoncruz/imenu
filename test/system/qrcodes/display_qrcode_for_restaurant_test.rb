# frozen_string_literal: true

require 'application_system_test_case'

class DisplayQrcodeForRestaurantTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test 'create qrcode for restaurant after register' do
    visit new_restaurant_registration_path

    within '.new_restaurant' do
      fill_in Restaurant.human_attribute_name(:name), with: 'Restaurant #1'
      fill_in Restaurant.human_attribute_name(:email), with: 'admin@restaurant1.com'
      fill_in Restaurant.human_attribute_name(:password), with: '123123'
      fill_in Restaurant.human_attribute_name(:password_confirmation), with: '123123'

      click_on I18n.t('helpers.submit.restaurant.create')
    end

    assert_current_path '/accounts/sign_in'

    perform_enqueued_jobs

    restaurant = Restaurant.last

    restaurant.update(confirmed_at: Time.current)

    login_as(restaurant)

    visit restaurant_path(restaurant)

    click_on I18n.t('navbar.qrcodes')

    assert_css("img[src*='#{restaurant.qrcode.filename}']")
  end
end
