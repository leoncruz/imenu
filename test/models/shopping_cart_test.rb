# frozen_string_literal: true

require 'test_helper'

class ShoppingCartTest < ActiveSupport::TestCase
  setup do
    @shopping_cart = ShoppingCart.new(table_id: 1, anonymous_client_id: 2)
  end

  test 'initialize a new shopping cart with id' do
    assert_equal '1:2', @shopping_cart.id
  end

  test 'add item to cart' do
    @shopping_cart.add_item 10

    assert_equal ['10'], @shopping_cart.elements
  end

  test 'increse amount of an item' do
    @shopping_cart.add_item 10

    @shopping_cart.increase_item(10)
    @shopping_cart.increase_item(10)

    assert_equal 3, @shopping_cart['10']
  end

  test 'decrease amount of an item' do
    @shopping_cart.add_item 10

    @shopping_cart.increase_item(10)
    @shopping_cart.increase_item(10)

    assert_equal 3, @shopping_cart['10']

    @shopping_cart.decrease_item(10)
    @shopping_cart.decrease_item(10)

    assert_equal 1, @shopping_cart['10']
  end
end
