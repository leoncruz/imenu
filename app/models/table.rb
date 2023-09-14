# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :restaurant

  validates :code, presence: true, uniqueness: { scope: :restaurant }
end
