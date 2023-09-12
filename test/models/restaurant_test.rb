# frozen_string_literal: true

require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  test 'must be invalid without name' do
    restaurant = Restaurant.new

    restaurant.valid?

    assert_equal restaurant.errors[:name], [I18n.t('errors.messages.blank')]
  end
end
