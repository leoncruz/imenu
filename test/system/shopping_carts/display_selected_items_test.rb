# frozen_string_literal: true

require 'application_system_test_case'

class DisplaySelectedItemsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:burger_king)

    @table = @restaurant.tables.first

    visit restaurant_table_check_availability_path(@restaurant, @table)
  end

  test 'display cart items for order' do
    within :xpath, '//div/div[2]/div[1]/div[2]/div[1]' do
      click_on 'Add to cart Icon'
    end

    within :xpath, '//div/div[2]/div[2]/div[2]/div[1]' do
      click_on 'Add to cart Icon'
    end

    click_link '', href: shopping_cart_path

    assert_text I18n.t('shopping_carts.show.title')

    assert_text @restaurant.items.first.name

    assert_text @restaurant.items.second.name
  end

  test 'increase and decrease item quanitty' do
    within :xpath, '//div/div[2]/div[1]/div[2]/div[1]' do
      click_on 'Add to cart Icon'
    end

    click_link '', href: shopping_cart_path

    item = @restaurant.items.second

    assert_text item.name

    2.times do
      click_link '', href: increase_shopping_cart_item_path(item)
    end

    within "#shopping_cart_quantity_item_#{item.id}" do
      assert_text '3'
    end

    2.times do
      click_link '', href: decrease_shopping_cart_item_path(item)
    end

    within "#shopping_cart_quantity_item_#{item.id}" do
      assert_text '1'
    end
  end
end
