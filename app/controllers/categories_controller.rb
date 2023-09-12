# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_menu
  before_action :set_category, only: [:edit, :update, :destroy]

  def new
    @category = @menu.categories.build
  end

  def edit; end

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

  def update
    if @category.update(category_params)
      render turbo_stream: turbo_stream.replace(@category)
    else
      render turbo_stream: [
        turbo_stream.replace(dom_id(@category, :edit), template: 'categories/edit', formats: [:html])
      ]
    end
  end

  def destroy
    @category.destroy
  end

  private

  def set_menu
    @menu = current_restaurant.menu
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = @menu.categories.find(params[:id])
  end
end
