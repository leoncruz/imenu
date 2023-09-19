# frozen_string_literal: true

require 'application_system_test_case'

class RestaurantUserTest < ApplicationSystemTestCase
  test 'does not display shopping cart when restaurant is loggedin' do
    restaurant = restaurants(:spoleto)

    login_as(restaurant)

    visit restaurant_path(restaurant)

    refute_selector '.shopping-cart'
  end
end
