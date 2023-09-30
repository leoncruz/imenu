# frozen_string_literal: true

require 'application_system_test_case'

class AddItemWithoutSelectATable < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:burger_king)

    visit restaurant_path(@restaurant)
  end

  test 'client must select a table before add a item to cart' do
    @table = @restaurant.tables.first

    refute_text @table.code

    click_on 'Add to cart Icon', match: :first

    assert_text I18n.t('tables.select.index.title')

    click_on @table.code

    assert_text @table.code

    click_on 'Add to cart Icon', match: :first

    refute_text I18n.t('tables.select.index.title')

    within '.shopping-cart' do
      assert_text '1'
    end
  end
end
