# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :menu
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def dom_id
    @dom_id ||= ActionView::RecordIdentifier.dom_id(self, Time.current.to_i)
  end
end
