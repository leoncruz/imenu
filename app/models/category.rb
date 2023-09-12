# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :menu

  validates :name, presence: true, uniqueness: true
end
