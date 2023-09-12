# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_category

  def new
    @item = @category.items.build
  end

  def create
    @item = @category.items.build(item_params)

    if @item.save
      render turbo_stream: [
        turbo_stream.append("items_category_#{@category.id}", partial: 'items/item', locals: { item: @item }),
        turbo_stream.update('new_item', '')
      ]
    else
      render turbo_stream: [
        turbo_stream.replace('new_item', template: 'items/new', formats: [:html])
      ]
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :description)
  end
end
