Rails.application.routes.draw do

  devise_for :users

  # Home Pages
  get '/',                    to: 'visitor#index',            as: 'visitor'
  get '/roster',              to: 'member#index',             as: 'roster'
  get '/task/:id',            to: 'task#index'

  # Lookups
  get '/roster/feed',         to: 'member#rosterFeed'
  get '/task/:id/details',    to: 'member#getTaskDetails',    as: 'task_details'

  get '/roster/next',         to: 'member#getNextTask',       as: 'next_task'
  get '/users/userID',        to: 'member#getCurrentUserId',  as: 'get_current_user_id'

  # Callbacks
  post '/roster/addTask',     to: 'member#addTask',           as: 'add_task'
  post '/roster/updateTask',  to: 'member#updateTask',        as: 'update_task'
  get '/task/:id/closeTask',  to: 'member#closeTask',           as: 'close_task'
  get '/task/:id/acceptTask', to: 'member#acceptTask',        as: 'accept_task'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
