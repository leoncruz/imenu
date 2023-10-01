# frozen_string_literal: true

class ShoppingCartsController < ApplicationController
  include OrderScoped

  skip_before_action :authenticate_restaurant!

  def show
    @items = Item.find(shopping_cart.items)
  end

  def create
    shopping_cart.add_item(params[:item_id])

    flash.now[:notice] = t('.notice')

    render turbo_stream: [
      turbo_stream.update('flashes', partial: 'layouts/flash_messages'),
      turbo_stream.replace_all('.shopping-cart', partial: 'layouts/shopping_cart', locals: { shopping_cart: })
    ]
  end
end
