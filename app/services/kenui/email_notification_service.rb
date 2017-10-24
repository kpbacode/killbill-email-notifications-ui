module Kenui
  # class where email notification services resides
  class EmailNotificationService
    class << self

      def set_email_notification(account_id, is_notified, user = 'email_notification_ui',
                                 reason = nil, comment = nil, options = {})
        account = KillBillClient::Model::Account.new(:account_id => account_id, :is_notified_for_invoices => is_notified)

        account.update_email_notifications(user, reason, comment, options)
        return true, nil
      rescue => e
        return false, e.message.to_s
      end

      def email_notification_plugin_available?(options = nil)

        nodes_info = KillBillClient::Model::NodesInfo.nodes_info(options)
        plugins_info = nodes_info.first.plugins_info
        return !(plugins_info.find_index { |plugin| plugin.plugin_key == 'email-notifications'}).nil?, nil
      rescue => e
        return false, e.message.to_s
      end

    end
  end
end