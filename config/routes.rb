Rails.application.routes.default_url_options[:host] = 'avatar-generator.test'
Rails.application.routes.draw do
  root 'avatar#index'
end
