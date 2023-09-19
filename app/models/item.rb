# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :category
  has_one :menu, through: :category
  has_one :restaurant, through: :menu

  validates :name, presence: true, uniqueness: { scope: :category }
  validates :price, presence: true
end
