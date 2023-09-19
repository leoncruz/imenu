# frozen_string_literal: true

class ShoppingCart
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :table_id, :string
  attribute :anonymous_client_id, :string

  def self.find_or_create_by(table_id, anonymous_client_id)
    new(table_id:, anonymous_client_id:).tap(&:counter)
  end

  def id
    "#{table_id}-#{anonymous_client_id}"
  end

  def add_item(_id)
    counter.increment
  end

  def counter_key
    "#{id}-counter"
  end

  def counter
    @counter ||= Kredis.counter counter_key, expires_in: 1.hour
  end
end
