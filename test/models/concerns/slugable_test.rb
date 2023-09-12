# frozen_string_literal: true

require 'test_helper'

class SlugableTest < ActiveSupport::TestCase
  test 'slug must be filled if not informed' do
    restaurant = Restaurant.new(name: 'burger king')

    restaurant.valid?

    assert_equal 'burger-king', restaurant.slug
  end

  test 'use user slug when informed' do
    restaurant = Restaurant.new(name: 'burger king', slug: 'bk')

    restaurant.valid?

    assert_equal 'bk', restaurant.slug
  end

  test 'validate format of slug' do
    restaurant = Restaurant.new(slug: 'bk')

    restaurant.valid?

    assert_empty restaurant.errors[:slug]

    restaurant.slug = 'burger-king'

    restaurant.valid?

    assert_empty restaurant.errors[:slug]

    restaurant.slug = 'bk#10'

    restaurant.valid?

    assert_equal [I18n.t('errors.messages.invalid')], restaurant.errors[:slug]

    restaurant.slug = '10#bk'

    restaurant.valid?

    assert_equal [I18n.t('errors.messages.invalid')], restaurant.errors[:slug]
  end
end
