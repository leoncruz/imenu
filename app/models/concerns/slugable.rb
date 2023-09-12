# frozen_string_literal: true

module Slugable
  extend ActiveSupport::Concern

  included do
    before_validation :create_slug, if: -> { slug_base_field.present? && slug.blank? }

    validates :slug, presence: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
  end

  class_methods do
    def slug_base_field(field)
      define_method(:slug_base_field) do
        send(field)
      end
    end
  end

  def to_param
    slug
  end

  private

  def create_slug
    self.slug = slug_base_field.parameterize
  end
end
