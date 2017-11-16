Kenui::Engine.routes.draw do

  root to: 'email_notifications#index'

  resources :email_notifications, :only => [:index]

  scope '/email_notifications' do
    match '/pagination' => 'email_notifications#pagination', :via => :get, :as => 'email_notification_pagination'
    match '/configuration' => 'email_notifications#configuration', :via => :get, :as => 'email_notifications_get_configuration'
    match '/configuration' => 'email_notifications#set_configuration', :via => :post, :as => 'email_notifications_configuration'
    match '/events_to_consider' => 'email_notifications#events_to_consider', :via => :get, :as => 'email_notification_events_to_consider'
  end
end
