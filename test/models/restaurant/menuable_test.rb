# frozen_string_literal: true

require 'test_helper'

class MenuableTest < ActiveSupport::TestCase
  test 'has to create an menu after create a restaurant' do
    restaurant = Restaurant.new(
      name: 'La Traviata',
      email: 'admin@latraviata.com.br',
      password: '123123'
    )

    assert_difference 'Menu.count', 1 do
      restaurant.save
    end

    assert_equal restaurant.menu, Menu.last
  end
end
