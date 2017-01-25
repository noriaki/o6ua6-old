Rails.application.routes.draw do
  get 'gengo/random(/limit/:limit(/excepts/*excepts))', to: 'gengo#random', format: false

  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
