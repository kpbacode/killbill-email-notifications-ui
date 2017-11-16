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

      account_ids = rows.map { |account| account.account_id }
      email_notifications_configuration = Kenui::EmailNotificationService.get_configurations(account_ids, options_for_klient)

      rows.each do |row|

        configuration = email_notifications_configuration.select { |event| event[:kbAccountId] == row.account_id }
        events = configuration.map { |event| event[:eventType] }.join(', ')
        data << [
          row.name,
          row.account_id,
          events,
          view_context.link_to('<i class="fa fa-cog" aria-hidden="true"></i>'.html_safe,
                               '#configureEmailNotification',
                               data: { name: row.name, account_id: row.account_id,
                                       events: events, toggle: 'modal', target: '#configureEmailNotification'})
        ]
      end

      respond_to do |format|
        format.json { render json: { data: data, recordsTotal: record_total, recordsFiltered: record_total} }
      end
    end

    def events_to_consider
      data = Kenui::EmailNotificationService.get_events_to_consider(options_for_klient)

      respond_to do |format|
        format.json { render json: { data: data} }
      end
    end

    def configuration
      account_id = params.require(:account_id)
      data = Kenui::EmailNotificationService.get_configuration_per_account(account_id,options_for_klient)

      respond_to do |format|
        format.json { render json: { data: data} }
      end
    end

    def set_configuration
      configuration = params.require(:configuration)

      is_success, message = Kenui::EmailNotificationService.set_configuration_per_account(configuration[:account_id],
                                                                                          configuration[:event_types],
                                                                                          'kenui', nil, nil,
                                                                                          options_for_klient )

      if is_success
        flash[:notice] = message
      else
        flash[:error] = message
      end
      redirect_to email_notifications_path
    end

  end
end
