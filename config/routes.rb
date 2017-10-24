Kenui::Engine.routes.draw do

  root to: 'email_notifications#index'

  resources :email_notifications, :only => [:index]

  scope '/email_notifications' do
    match '/pagination' => 'email_notifications#pagination', :via => :get, :as => 'email_notification_pagination'
    match '/toggle' => 'email_notifications#toggle', :via => :post, :as => 'email_notifications_toggle'
  end
end
