# frozen_string_literal: true

module OrderScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_table,
                  :set_anonymous_client,
                  :set_shopping_cart, unless: -> { restaurant_signed_in? }
  end

  protected

  attr_reader :table, :anonymous_client, :shopping_cart

  def set_table
    @table = Table.find cookies.signed[:table] if cookies.signed[:table]

    @table_not_selected = @table ? false : true
  end

  def set_anonymous_client
    @anonymous_client =
      if cookies.signed.permanent[:anonymous_client]
        AnonymousClient.new(id: cookies.signed.permanent[:anonymous_client])
      else
        AnonymousClient.new.tap do |user|
          cookies.signed.permanent[:anonymous_client] = user.id
        end
      end
  end

  def set_shopping_cart
    @shopping_cart = ShoppingCart.find_or_create_by(table.id, anonymous_client.id) if table
  end
end
