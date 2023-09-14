# frozen_string_literal: true

require 'test_helper'

class TableTest < ActiveSupport::TestCase
  test 'must be invalid without code' do
    table = Table.new

    table.valid?

    assert_equal [I18n.t('errors.messages.blank')], table.errors[:code]
  end

  test 'code must be unique based on restaurant' do
    spoleto = restaurants(:spoleto)
    bk = restaurants(:burger_king)

    table = Table.new(code: 'TABLE-10', restaurant: spoleto)
    table.save

    other_table = Table.new(code: 'TABLE-10', restaurant: spoleto)
    other_table.valid?

    assert_equal [I18n.t('errors.messages.taken')], other_table.errors[:code]

    other_table.restaurant = bk

    other_table.valid?

    assert_empty other_table.errors[:code]
  end
end
