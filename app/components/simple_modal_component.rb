# frozen_string_literal: true

class SimpleModalComponent < ApplicationComponent
  renders_one :body

  def initialize(title, back_url)
    super

    @title = title
    @back_url = back_url
  end
end
