Rails.application.routes.draw do

  # Home Pages
  get '/', to: 'visitor#index'
  get '/roster', to: 'member#index'
  get '/task/:id', to: 'task#index'

  # Add Task to Roster
  get '/roster/addTask',  to: 'member#addTask'
  post '/roster/addTask', to: 'member#addTask'

  # Change Task on Roster
  get '/roster/:id/changeTask', to: 'member#changeTask'
  post '/roster/:id/changeTask', to: 'member#changeTask'

  # Assign Task to Tech
  get '/roster/:id/assignTask', to: 'member#assignTask'

  # Task Dialog
  post '/task/:id/addToTask', to: 'task#addToTask'

  # End Task
  post '/task/:id/closeTask', to: 'task#closeTask'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
