# frozen_string_literal: true

module ShoppingCarts
  class RemoveItemsController < ApplicationController
    include OrderScoped

    def destroy; end
  end
end
