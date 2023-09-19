# frozen_string_literal: true

require 'application_system_test_case'

class ShoppingCartTest < ApplicationSystemTestCase
  class RestaurantUserTest < ShoppingCartTest
    test 'does not display shopping cart when restaurant is loggedin' do
      restaurant = restaurants(:spoleto)

      login_as(restaurant)

      visit restaurant_path(restaurant)

      refute_selector '.shopping-cart'
    end
  end

  class AnonymousClientTest < ShoppingCartTest
    setup do
      @restaurant = restaurants(:burger_king)

      @table = @restaurant.tables.first

      visit restaurant_table_check_availability_path(@restaurant, @table)
    end

    test 'display the shopping cart for anonymous users' do
      assert_selector '.shopping-cart'
    end

    test 'select an item then add to cart' do
      click_on 'Add to cart Icon', match: :first

      within '.shopping-cart' do
        assert_text '1'
      end
    end

    test 'items on cart must be availables in 1 hour' do
      click_on 'Add to cart Icon', match: :first

      within '.shopping-cart' do
        assert_text '1'
      end

      # save cookies before close
      cookies = page.driver.browser.manage.all_cookies

      page.quit

      travel_to 30.minutes.since

      visit '/'

      # Restore the cookies in the new session
      cookies.each do |cookie|
        page.driver.browser.manage.add_cookie(cookie)
      end

      visit restaurant_table_check_availability_path(@restaurant, @table)

      within '.shopping-cart' do
        assert_text '1'
      end

      page.quit

      travel_to 2.hours.since

      visit restaurant_table_check_availability_path(@restaurant, @table)

      cookies.each do |cookie|
        page.driver.browser.manage.add_cookie(cookie)
      end

      within '.shopping-cart' do
        assert_text '0'
      end
    end
  end
end
