
Rails.application.routes.draw do
  # Mount the real-time WebSocket server directly under /cable
  mount ActionCable.server => '/cable'
  get "up" => "rails/health#show", as: :rails_health_check

  # Set up our scoped HTTP API namespaces
  scope :api do
    scope :v1 do
      get 'simulations', to: 'simulations#index'
      post 'simulations/start', to: 'simulations#start'
    end
  end
end
