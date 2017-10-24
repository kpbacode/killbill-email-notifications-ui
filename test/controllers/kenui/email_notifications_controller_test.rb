require 'test_helper'

module Kenui
  class EmailNotificationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'should get index' do
      get email_notifications_url
      assert_response :success
    end
  end
end
