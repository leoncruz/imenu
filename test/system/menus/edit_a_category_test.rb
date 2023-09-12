# frozen_string_literal: true

require 'application_system_test_case'

class EditACategoryTest < ApplicationSystemTestCase
  setup do
    restaurant = restaurants(:burger_king)

    login_as restaurant

    visit restaurant_path(restaurant)

    click_on I18n.t('navbar.menu')
  end

  test 'updates a category name' do
    category = categories(:desserts)

    within "#category_#{category.id}" do
      click_on I18n.t('categories.category.edit')

      fill_in Item.human_attribute_name(:name), with: 'Desserts'

      click_on I18n.t('helpers.submit.category.update')

      assert_text 'Desserts'
    end
  end

  test 'display error message if update fails' do
    category = categories(:desserts)

    within "#category_#{category.id}" do
      click_on I18n.t('categories.category.edit')

      fill_in Item.human_attribute_name(:name), with: ''

      click_on I18n.t('helpers.submit.category.update')

      assert_text I18n.t('errors.messages.blank')
    end
  end
end
