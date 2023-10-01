# frozen_string_literal: true

class ShoppingCart
  attr_accessor :table_id, :anonymous_client_id

  delegate :<<, :append, :elements, to: :items_list
  delegate :[], to: :quantity_by_item

  alias items elements

  def initialize(table_id:, anonymous_client_id:)
    @table_id = table_id
    @anonymous_client_id = anonymous_client_id
  end

  def id
    "#{table_id}:#{anonymous_client_id}"
  end

  def add_item(id)
    items_list.append(id)
    quantity_by_item.update(id => 1)
  end

  def increase_item(id)
    quantity_by_item.hincrby id, 1
  end

  def decrease_item(id)
    quantity_by_item.hincrby id, -1
  end

  private

  def items_list
    @items_list ||= Kredis.list items_key, expires_in: 1.hour
  end

  def quantity_by_item
    @quantity_by_item ||=
      Kredis.hash quantity_by_item_key, expires_in: 1.hour, typed: :integer
  end

  def items_key
    "shopping_cart:item:#{id}"
  end

  def quantity_by_item_key
    "shopping_cart:quantity_by_item:#{id}"
  end
end
