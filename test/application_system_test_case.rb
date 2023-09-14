# frozen_string_literal: true

require 'test_helper'
require 'support/download_helpers'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400] do |driver_options|
    driver_options.add_preference(:download, default_directory: DOWNLOAD_PATH.to_s)
  end

  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  include DownloadHelpers

  setup do
    clear_downloads
  end

  teardown do
    clear_downloads
  end
end
