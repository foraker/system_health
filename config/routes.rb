Rails.application.routes.draw do
  namespace :system_health do
    resource :monitor, :only => :show
  end
end
