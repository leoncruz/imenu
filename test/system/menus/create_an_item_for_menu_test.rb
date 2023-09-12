# frozen_string_literal: true

require 'application_system_test_case'

class CreateAnItemForMenuTest < ApplicationSystemTestCase
  setup do
    restaurant = restaurants(:burger_king)

    login_as restaurant

    visit restaurant_path(restaurant)

    click_on I18n.t('navbar.menu')
  end

  test 'add a new item for a menu category' do
    category = categories(:burgers)

    within "#category_#{category.id}" do
      click_on I18n.t('categories.category.new_item')

      fill_in Item.human_attribute_name(:name), with: 'Burger King Master'

      fill_in Item.human_attribute_name(:price), with: '40,00'

      click_on I18n.t('helpers.submit.item.create')

      assert_text 'Burger King Master'

      assert_text '40,00'

      assert_selector '.item', count: 2
    end
  end

  test 'display errors for invalid form' do
    category = categories(:burgers)

    within "#category_#{category.id}" do
      click_on I18n.t('categories.category.new_item')

      click_on I18n.t('helpers.submit.item.create')

      assert_text I18n.t('errors.messages.blank'), count: 2
    end
  end
end
