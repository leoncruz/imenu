# frozen_string_literal: true

class Restaurant < ApplicationRecord
  include Slugable, Menuable, QrcodeGeneratable

  slug_base_field :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
end
