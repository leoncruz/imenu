# frozen_string_literal: true

class Restaurant < ApplicationRecord
  include Slugable

  slug_base_field :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :menu, dependent: :destroy

  validates :name, presence: true
end
