# frozen_string_literal: true

module ShoppingCarts
  class IncreaseItemsController < ApplicationController
    skip_before_action :authenticate_restaurant!

    include OrderScoped

    def update
      item = Item.find(params[:item_id])

      shopping_cart.increase_item(item.id)

      render turbo_stream: [
        turbo_stream.replace(
          dom_id(item, :shopping_cart_quantity),
          partial: 'shopping_carts/item_quantity',
          locals: {
            shopping_cart:,
            item:
          }
        )
      ]
    end
  end
end
