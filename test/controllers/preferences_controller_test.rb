# frozen_string_literal: true

require "test_helper"

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @preference = @user.preference
    @headers = headers(@user)
  end
  def test_show_preference_for_a_valid_user
    get preference_path(@user.id), headers: @headers
    assert_response :ok
    assert_equal response.parsed_body["preference"]["id"], @preference.id
  end
  def test_update_success
    preference_params = { preference: { receive_email: false } }

    put preference_path(@preference.id), params: preference_params, headers: @headers
    @preference.reload
    assert_response :ok
    refute @preference.receive_email
  end

  def test_update_failure_for_invalid_notification_delivery_hour
    preference_params = { preference: { notification_delivery_hour: 24 } }

    put preference_path(@preference.id), params: preference_params, headers: @headers
    assert_response :unprocessable_entity
    assert_equal response.parsed_body["error"],
      "Notification delivery hour #{t("preference.notification_delivery_hour.range")}"
  end
  def test_not_found_error_rendered_when_updating_preference_with_invalid_preference_id
    patch preference_path("invalid_id"), params: { notification_delivery_hour: 14 }, headers: @headers
    assert_response :not_found
    assert_equal response.parsed_body["error"], t("not_found", entity: "Preference")
  end
  def test_unauthorized_user_cannot_access_preference_of_other_users
    unauthorized_user = create(:user)
    headers = headers(unauthorized_user)

    get preference_path(@preference.id), headers: headers
    assert_response :forbidden
    assert_equal response.parsed_body["error"], t("authorization.denied")
  end

  def test_unauthorized_user_cannot_update_preferences_of_other_users
    unauthorized_user = create(:user)
    headers = headers(unauthorized_user)
    preference_params = { preference: { receive_email: false } }

    put preference_path(@preference.id), params: preference_params, headers: headers
    assert_response :forbidden
    assert_equal response.parsed_body["error"], t("authorization.denied")
  end
end
