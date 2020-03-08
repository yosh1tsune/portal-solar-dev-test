Rails.application.routes.draw do
  root to: 'power_generators#index'

  resources :power_generators, only: %i[index show] do
    get 'recommend', on: :collection
    get 'set_freight', on: :member
  end
end
