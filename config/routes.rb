Rails.application.routes.draw do
  root to: 'site#index', as: :index

  #!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ USER ROUTES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!#
  # method    path                      controller#action           alias
  get         'users/new',              to: 'users#new',            as: :new_user
  post        'users',                  to: 'users#create'
  get         'users/:id/edit',         to: 'users#edit',           as: :edit_user
  patch       'users/:id',              to: 'users#update',          as: :update_user
  get         'users/:id',              to: 'users#show',           as: :user
  delete      'users/:id',              to: 'users#destroy',         as: :destroy_user


  resources :testimonies, :except => :destroy do
    resources :comments, :except => :destroy
  end
  delete      'comments/:id',              to: 'comments#destroy',         as: :destroy_comment
  delete      'testimonies/:id',              to: 'testimonies#destroy',         as: :destroy_testimony

  # #!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TESTIMONY ROUTES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!#
  # # method    path                      controller#action           alias
  #
  # get         'testimonies/index',           to: 'testimonies#index',        as: :index_testimony
  # get         'testimonies/new',              to: 'testimonies#new',            as: :new_testimony
  # post        'testimonies',                  to: 'testimonies#create',          as: :create_testimony
  # get         'testimonies/:id/edit',         to: 'testimonies#edit',           as: :edit_testimony
  # patch       'testimonies/:id',              to: 'testimonies#update',          as: :update_testimony
  # get         'testimonies/:id',              to: 'testimonies#show',           as: :testimony
  # delete      'testimonies/:id',              to: 'testimonies#destroy',         as: :destroy_testimony
  #
  # #!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ COMMENT ROUTES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!#
  # # method    path                      controller#action           alias
  # get         'comments/new',              to: 'comments#new',            as: :new_comment
  # post        'comments',                  to: 'comments#create',          as: :create_comment
  # get         'comments/:id/edit',         to: 'comments#edit',           as: :edit_comment
  # patch       'comments/:id',              to: 'comments#update',          as: :update_comment
  # get         'comments/:id',              to: 'comments#show',           as: :comment
  # delete      'comments/:id',              to: 'comments#destroy',         as: :destroy_comment

  #!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SESSION ROUTES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!#
    # method    path                      controller#action           alias
    get         '/login',                 to: 'sessions#new',         as: :login
    post        '/sessions',              to: 'sessions#create'
    get         '/logout',                to: 'sessions#destroy',      as: :logout

end
