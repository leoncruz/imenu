# frozen_string_literal: true

require 'application_system_test_case'

class UpdateTableTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:spoleto)

    login_as(@restaurant)

    visit restaurant_path(@restaurant)
  end

  test 'update a restaurant table' do
    click_on I18n.t('navbar.tables')

    table = tables(:spoleto_table)

    within "#table_#{table.id}" do
      accept_alert do
        click_on I18n.t('helpers.actions.remove')
      end
    end

    refute_selector 'span', text: table.code
  end
end
