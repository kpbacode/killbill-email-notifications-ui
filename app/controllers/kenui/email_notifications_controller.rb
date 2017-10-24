module Kenui
  class EmailNotificationsController < Kenui::EngineController

    def index
      @record_total = (KillBillClient::Model::Account.find_in_batches(nil,nil,false,false,options_for_klient) || []).size
    end

    # get account list, no sorting
    def pagination
      search_key = (params[:search] || {})[:value].presence
      offset = (params[:start] || 0).to_i
      limit = (params[:length] || 50).to_i
      record_total = (params[:record_total] || 100).to_i
      data = []

      if search_key.present?
        rows = KillBillClient::Model::Account.find_in_batches_by_search_key(search_key, offset, limit, false, false, options_for_klient)
      else
        rows = KillBillClient::Model::Account.find_in_batches(offset, limit, false, false, options_for_klient)
      end

      rows.each do |row|
        data << [
          row.name,
          row.account_id,
          view_context.button_to(row.is_notified_for_invoices ? 'YES' : 'NO',
                                 email_notifications_toggle_path(account_id: row.account_id,
                                                                 is_notified: !row.is_notified_for_invoices),
                                 method: :post,
                                 class: row.is_notified_for_invoices ? 'btn btn-success' : 'btn btn-danger')
        ]
      end

      respond_to do |format|
        format.json { render json: { data: data, recordsTotal: record_total, recordsFiltered: record_total} }
      end
    end

    def toggle

      is_success, error = Kenui::EmailNotificationService.set_email_notification(params.require(:account_id),
                                                                                 params[:is_notified] == 'true',
                                                                                 'email_notification_ui',nil,
                                                                                 nil, options_for_klient )

      if is_success
        flash[:notice] = "Email preferences updated"
      else
        flash[:error] = error
      end
      redirect_to email_notifications_path
    end

  end
end
