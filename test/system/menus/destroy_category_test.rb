# frozen_string_literal: true

require 'application_system_test_case'

class CreateCategoryTest < ApplicationSystemTestCase
  setup do
    restaurant = restaurants(:burger_king)

    login_as restaurant

    visit restaurant_path(restaurant)

    click_on I18n.t('navbar.menu')
  end

  test 'remove a category from menu' do
    burgers = categories(:burgers)

    within "#category_#{burgers.id}" do
      accept_alert I18n.t('helpers.alert.destroy') do
        click_on I18n.t('categories.category.remove')
      end
    end

    within '.categories' do
      assert_selector '.category', count: 1
    end
  end
end
