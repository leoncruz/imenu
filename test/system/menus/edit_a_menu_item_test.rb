# frozen_string_literal: true

require 'application_system_test_case'

class EditAMenuItem < ApplicationSystemTestCase
  setup do
    restaurant = restaurants(:burger_king)

    login_as restaurant

    visit restaurant_path(restaurant)

    click_on I18n.t('navbar.menu')
  end

  test 'updates an item from a category' do
    item = items(:burger_jr)

    within "#item_#{item.id}" do
      click_on I18n.t('categories.category.edit')
    end

    fill_in Item.human_attribute_name(:price), with: '40,00'

    click_on I18n.t('helpers.submit.item.update')

    within "#item_#{item.id}" do
      assert_text '40,00'
    end
  end

  test 'display errors when update fails' do
    item = items(:burger_jr)

    within "#item_#{item.id}" do
      click_on I18n.t('categories.category.edit')
    end

    fill_in Item.human_attribute_name(:price), with: ''

    click_on I18n.t('helpers.submit.item.update')

    assert_text I18n.t('errors.messages.blank')
  end
end
