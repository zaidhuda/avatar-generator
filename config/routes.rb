Rails.application.routes.draw do
  root 'docs#index'
  get 'i', to: 'avatar#index', as: 'img'
  get 'options', to: 'docs#options'
  get 'examples', to: 'docs#examples'
end
