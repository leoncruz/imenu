# frozen_string_literal: true

class AnonymousClient
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string, default: -> { SecureRandom.uuid }
end
