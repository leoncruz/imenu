# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :menu
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
