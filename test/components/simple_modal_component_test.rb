# frozen_string_literal: true

require 'test_helper'

class SimpleModalComponentTest < ViewComponent::TestCase
  test 'renders a modal component' do
    modal = SimpleModalComponent.new('New Item', '/back/url').tap do |m|
      m.with_body { '<h1>Modal Body</h1>'.html_safe }
    end

    render_inline(modal)

    assert_selector 'h1', text: 'Modal Body'

    assert_selector 'h3', text: 'New Item'

    assert_selector 'a[href="/back/url"]'
  end
end
