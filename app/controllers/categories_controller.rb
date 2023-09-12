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
        turbo_stream.replace(category_dom_id, partial: 'categories/category', locals: { category: @category })
      ]
    else
      render turbo_stream: [
        turbo_stream.replace(category_dom_id, template: 'categories/new', formats: [:turbo_stream])
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

  def category_dom_id
    params[:category][:dom_id]
  end
end
