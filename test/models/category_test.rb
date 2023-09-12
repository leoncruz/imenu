# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'must be invalid without name' do
    category = Category.new

    category.valid?

    assert_equal category.errors[:name], [I18n.t('errors.messages.blank')]
  end

  test 'name must be unique' do
    category = categories(:burgers)

    new_category = Category.new(name: category.name, menu: category.menu)

    new_category.valid?

    assert_equal new_category.errors[:name], [I18n.t('errors.messages.taken')]
  end
end
