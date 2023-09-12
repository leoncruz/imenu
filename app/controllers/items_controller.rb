# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_category, only: [:new, :create]
  before_action :set_item, only: [:edit, :update, :destroy]

  def new
    @item = @category.items.build
  end

  def edit; end

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

  def update
    if @item.update(item_params)
      render turbo_stream: [
        turbo_stream.replace(@item),
        turbo_stream.update('edit_item', '')
      ]
    else
      render turbo_stream: turbo_stream.replace('edit_item', template: 'items/edit', formats: [:html])
    end
  end

  def destroy
    @item = Item.find(params[:id])

    @item.destroy

    render turbo_stream: turbo_stream.remove(@item)
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :description)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
