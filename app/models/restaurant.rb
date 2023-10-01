# frozen_string_literal: true

class Restaurant < ApplicationRecord
  include Slugable, Menuable, QrcodeGeneratable

  slug_base_field :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :tables, dependent: :destroy
  has_many :categories, through: :menu
  has_many :items, through: :categories
  has_one :menu, dependent: :destroy

  validates :name, presence: true

  private

  def qrcode_url
    Rails.application.routes.url_helpers.restaurant_url(self)
  end
end
