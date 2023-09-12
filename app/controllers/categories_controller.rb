# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_menu

  def new
    @category = @menu.categories.build
  end

  def create
    @category = @menu.categories.build(category_params)

    if @category.save
      render turbo_stream: [
        turbo_stream.append('list_categories', partial: 'categories/category', locals: { category: @category }),
        turbo_stream.update('new_category', '')
      ]
    else
      render turbo_stream: [
        turbo_stream.replace('new_category', template: 'categories/new', formats: [:html])
      ]
    end
  end

  def destroy
    @category = Category.find(params[:id])

    @category.destroy
  end

  private

  def set_menu
    @menu = current_restaurant.menu
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
