# frozen_string_literal: true

require 'application_system_test_case'

class CreateCategoryTest < ApplicationSystemTestCase
  setup do
    restaurant = restaurants(:spoleto)

    login_as restaurant

    visit restaurant_path(restaurant)

    click_on I18n.t('navbar.menu')
  end

  test 'create a new category to a menu' do
    click_on I18n.t('menus.form.add_category')

    fill_in I18n.t('activerecord.attributes.restaurant.name'), with: 'Desserts'

    click_on I18n.t('helpers.submit.category.create')

    assert_text 'Desserts'

    assert_text I18n.t('categories.category.new_item')

    assert_text I18n.t('categories.category.edit')

    assert_text I18n.t('categories.category.remove')
  end

  test 'display error when creation fails' do
    click_on I18n.t('menus.form.add_category')

    click_on I18n.t('helpers.submit.category.create')

    assert_text I18n.t('errors.messages.blank')
  end
end
