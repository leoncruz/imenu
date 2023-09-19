# frozen_string_literal: true

class AddToCartButtonComponent < ApplicationComponent
  def initialize(anonymous_client, item, table_not_selected)
    super

    @anonymous_client = anonymous_client
    @item = item
    @table_not_selected = table_not_selected
  end

  def url
    if @table_not_selected
      route_helpers.restaurant_select_table_path(@item.restaurant)
    else
      route_helpers.shopping_carts_add_path(item_id: @item.id)
    end
  end

  def turbo_attributes
    if @table_not_selected
      {
        turbo_frame: 'select_tables', turbo_stream: true
      }
    else
      { turbo_method: :patch }
    end
  end

  def render?
    @anonymous_client.present?
  end

  private

  def route_helpers
    @route_helpers ||= Rails.application.routes.url_helpers
  end
end
