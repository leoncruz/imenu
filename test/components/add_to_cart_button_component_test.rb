# frozen_string_literal: true

require 'test_helper'

class AddToCartButtonComponentTest < ViewComponent::TestCase
  setup do
    @item = items(:burger_jr)
    @anonymouts_client = AnonymousClient.new
  end

  test 'does not render if anonymous client is not present' do
    render_inline(AddToCartButtonComponent.new(false, @item, false))

    refute_component_rendered
  end

  test 'render if anonymous client is present' do
    render_inline(AddToCartButtonComponent.new(@anonymouts_client, @item, false))

    assert_selector 'a'
  end

  test 'if table is not selected, link url must be to the select table path' do
    render_inline(AddToCartButtonComponent.new(@anonymouts_client, @item, true))

    url = Rails.application.routes.url_helpers.restaurant_select_table_path(@item.restaurant)

    assert_selector "a[href='#{url}']"
  end

  test 'if table is not selected, turbo attributes must be turbo_frame to select_tables' do
    render_inline(AddToCartButtonComponent.new(@anonymouts_client, @item, true))

    assert_selector "a[data-turbo-frame='select_tables']"
  end

  test 'if table is selected, link url must be to the add item to cart' do
    render_inline(AddToCartButtonComponent.new(@anonymouts_client, @item, false))

    url = Rails.application.routes.url_helpers.shopping_carts_add_path(item_id: @item.id)

    assert_selector "a[href='#{url}']"
  end

  test 'if table is not selected, turbo attributes must be turbo_method patch' do
    render_inline(AddToCartButtonComponent.new(@anonymouts_client, @item, false))

    assert_selector "a[data-turbo-method='patch']"
  end
end
