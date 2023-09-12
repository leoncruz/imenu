# frozen_string_literal: true

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'must be invalid without name' do
    item = Item.new

    item.valid?

    assert_equal item.errors[:name], [I18n.t('errors.messages.blank')]
  end

  test 'must have an unique name' do
    old_item = items(:burger_jr)

    item = Item.new(name: old_item.name)

    item.valid?

    assert_equal item.errors[:name], [I18n.t('errors.messages.taken')]
  end

  test 'must be invalid without price' do
    item = Item.new

    item.valid?

    assert_equal item.errors[:price], [I18n.t('errors.messages.blank')]
  end
end
