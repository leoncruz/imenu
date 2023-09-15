# frozen_string_literal: true

require 'application_system_test_case'

class CreateTableTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:spoleto)

    login_as @restaurant

    visit restaurant_path(@restaurant)
  end

  test 'display new table after create' do
    click_on I18n.t('navbar.tables')

    click_on I18n.t('tables.index.new_table')

    within 'form' do
      fill_in Table.human_attribute_name(:code), with: 'T1'

      click_on I18n.t('helpers.submit.table.create')
    end

    assert_selector 'span', text: 'T1'
  end
end
