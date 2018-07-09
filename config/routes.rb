Rails.application.routes.draw do

  devise_for :users

  # Home Pages
  get   '/',                    to: 'visitor#index',            as: 'visitor'
  get   '/roster',              to: 'member#index',             as: 'roster'
  get   '/task/:id',            to: 'task#index',               as: 'task'
  get   '/task/:id/dialog',     to: 'task#dialog',              as: 'dialog'

  # Lookups
  get   '/roster/feed',         to: 'member#rosterFeed'
  get   '/roster/next',         to: 'member#getNextTask',       as: 'next_task'
  get   '/users/userID',        to: 'member#getCurrentUserId',  as: 'get_current_user_id'

  get   '/task/:id/details',    to: 'task#details',             as: 'task_details'

  # Callbacks
  post  '/roster/add',          to: 'member#add',               as: 'add_task'
  post  '/roster/update',       to: 'member#update',            as: 'update_task'
  post  '/task/:id/dialog/message',    to: 'task#message',             as: 'dialog_message'

  get   '/task/:id/complete',   to: 'task#complete',            as: 'close_task'
  get   '/task/:id/accept',     to: 'task#accept',              as: 'accept_task'
end
