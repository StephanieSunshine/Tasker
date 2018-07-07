Rails.application.routes.draw do

  devise_for :users
  # Home Pages
  get '/', to: 'visitor#index', as: 'visitor'
  get '/roster', to: 'member#index', as: 'roster'
  get '/task/:id', to: 'task#index'

  # Add Task to Roster
  get '/roster/addTask',  to: 'member#addTask', as: 'add_task'
  post '/roster/addTask', to: 'member#addTask'

  # Change Task on Roster
  get '/roster/:id/changeTask', to: 'member#changeTask', as: 'change_task'
  post '/roster/:id/changeTask', to: 'member#changeTask'

  # Assign Task to Tech
  get '/roster/assignTask', to: 'member#assignTask', as: 'assign_task'

  # Task Dialog
  post '/task/:id/addToTask', to: 'task#addToTask', as: 'update_task'

  # End Task
  post '/task/:id/closeTask', to: 'task#closeTask', as: 'close_task'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
