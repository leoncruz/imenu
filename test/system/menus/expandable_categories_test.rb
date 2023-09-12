# frozen_string_literal: true

require 'application_system_test_case'

class ExpandableMenu < ApplicationSystemTestCase
  setup do
    restaurant = restaurants(:burger_king)

    login_as restaurant

    visit restaurant_path(restaurant)
  end

  test '' do
    Capybara.enable_aria_label = true

    assert_text items(:burger_jr).name

    click_on 'Toggle Items', match: :first

    refute_text items(:burger_jr).name

    click_on 'Toggle Items', match: :first

    assert_text items(:burger_jr).name
  end
end
