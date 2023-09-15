# frozen_string_literal: true

class TablesController < ApplicationController
  before_action :set_table, only: [:edit, :update, :destroy]

  def index
    @tables = current_restaurant.tables.with_attached_qrcode
  end

  def new
    @table = current_restaurant.tables.build
  end

  def edit; end

  def create
    @table = current_restaurant.tables.build(table_params)

    if @table.save
      render turbo_stream: [
        turbo_stream.append('tables-list', partial: 'tables/table', locals: { table: @table }),
        turbo_stream.update('new_table', '')
      ]
    else
      render turbo_stream: [
        turbo_stream.replace('new_table', template: 'tables/new', formats: [:html])
      ]
    end
  end

  def update
    if @table.update(table_params)
      render turbo_stream: [
        turbo_stream.replace(@table),
        turbo_stream.update('edit_table', '')
      ]
    else
      render turbo_stream: [
        turbo_stream.replace('edit_table', template: 'tables/edit', formats: [:html])
      ]
    end
  end

  def destroy
    @table.destroy
  end

  private

  def table_params
    params.require(:table).permit(:code)
  end

  def set_table
    @table = current_restaurant.tables.find(params[:id])
  end

  def from_qrcodes_page?
    params[:from] == 'qrcodes'
  end
  helper_method :from_qrcodes_page?
end
