# frozen_string_literal: true

require 'kenui/engine'

module Kenui
  mattr_accessor :current_tenant_user
  mattr_accessor :layout

  self.current_tenant_user = lambda { |_session, _user|
    { username: 'admin',
      password: 'password',
      session_id: nil,
      api_key: KillBillClient.api_key,
      api_secret: KillBillClient.api_secret }
  }

  def self.config
    {
      layout: layout || 'kenui/layouts/kenui_application'
    }
  end
end
