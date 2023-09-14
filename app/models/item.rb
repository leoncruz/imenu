# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: { scope: :category }
  validates :price, presence: true
end
