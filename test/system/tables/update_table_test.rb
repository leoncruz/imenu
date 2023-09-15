# frozen_string_literal: true

require 'application_system_test_case'

class DestroyTableTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:spoleto)

    login_as(@restaurant)

    visit restaurant_path(@restaurant)
  end

  test 'destroy table for restaurant' do
    click_on I18n.t('navbar.tables')

    table = tables(:spoleto_table)

    within "#table_#{table.id}" do
      click_on I18n.t('helpers.actions.edit')
    end

    within 'form' do
      fill_in Table.human_attribute_name(:code), with: 'Spoleto1'

      click_on I18n.t('helpers.submit.table.update')
    end

    assert_selector 'span', text: 'Spoleto1'
  end
end
