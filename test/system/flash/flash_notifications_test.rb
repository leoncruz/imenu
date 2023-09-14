# frozen_string_literal: true

require 'application_system_test_case'

class FlashNotificationsTest < ApplicationSystemTestCase
  class WarningFlashNotificationsTest < FlashNotificationsTest
    setup do
      visit new_restaurant_session_path

      within '.new_restaurant' do
        click_on I18n.t('devise.sessions.new.sign_in')
      end
    end

    test 'display a warning notification for alert flash messages' do
      assert_text I18n.t('devise.failure.invalid', authentication_keys: Restaurant.human_attribute_name(:email))

      assert_text 'Warning icon'
    end

    test 'flash message should disappear after 3 seconds' do
      assert_text I18n.t('devise.failure.invalid', authentication_keys: Restaurant.human_attribute_name(:email))

      sleep 3

      refute_text I18n.t('devise.failure.invalid', authentication_keys: Restaurant.human_attribute_name(:email))
    end

    test 'flash message should disappear after click on close button' do
      assert_text I18n.t('devise.failure.invalid', authentication_keys: Restaurant.human_attribute_name(:email))

      click_on 'Close' # aria-label

      refute_text I18n.t('devise.failure.invalid', authentication_keys: Restaurant.human_attribute_name(:email))
    end
  end

  class SuccessFlashNotificationsTest < FlashNotificationsTest
    test 'display a success notification for notice flash messages' do
      visit new_restaurant_session_path

      within '.new_restaurant' do
        fill_in Restaurant.human_attribute_name(:email), with: 'bk@email.com'
        fill_in Restaurant.human_attribute_name(:password), with: '123123'

        click_on I18n.t('devise.sessions.new.sign_in')
      end

      assert_text I18n.t('devise.sessions.signed_in')
    end
  end
end
