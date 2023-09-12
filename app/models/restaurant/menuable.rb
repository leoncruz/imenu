# frozen_string_literal: true

module Restaurant::Menuable
  extend ActiveSupport::Concern

  included do
    has_one :menu, dependent: :destroy

    after_create :create_menu
  end

  private

  def create_menu
    build_menu.save!
  end
end
