# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class Tables::CheckAvailabilityTest < ActionDispatch::IntegrationTest
  test 'redirect to menu if table is available' do
    restaurant = restaurants(:burger_king)
    table = restaurant.tables.first

    get restaurant_table_check_availability_path(restaurant, table)

    assert_response :redirect

    follow_redirect!

    assert_response :success
  end
end
