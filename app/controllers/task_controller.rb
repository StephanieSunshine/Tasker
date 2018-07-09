class TaskController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :authenticate_user!

  def index
    params.require(:id)
    @task = Task.new
    @response = Task.find(params[:id]).attributes
    logger.debug @response
    @response['created_by']=User.find(@response['user_id']).email
    @response['last_update']=distance_of_time_in_words(Time.now, @response['updated_at'])+' ago'
    @response['age']=distance_of_time_in_words(Time.now, @response['created_at'])+' ago'
    @response['state_color'] = "table-warning"
    @response['age_color'] = "table-success"
    @response['last_update_color'] = "table-danger"
    @response['body']  = (@response['body'].split("\r\n").map {|e| "<p class='lead'>#{Rinku.auto_link e}</p>" }).join
  end

  def dialog
    params.require(:id)
    @id = params[:id];
    @task = Task.new
    @messages = Task.find(params[:id]).messages.map do |m|
      response = m.attributes
      u=User.find(m['user'])
      response['tech']=u.tech;
      response['user']=u.email;
      response['created_at']=distance_of_time_in_words(Time.now, m['created_at'])+' ago'
      response['data']  = (m['data'].split("\r\n").map {|e| "<p class='lead card-text pl-5 pr-5'>#{Rinku.auto_link e}</p>" }).join
      response
    end
  end

  def complete
    params.require(:id)
    task = Task.find(params[:id])
    task.update({state: :completed}) if(current_user.tech && task.state.eql?("active"))
    redirect_to roster_url
  end

  def accept
    params.require(:id)
    task = Task.find(params[:id])
    task.update({assigned_to: current_user.id, state: :active}) if(current_user.tech && task.state.eql?("queued"))
    redirect_to '/task/'+params[:id]
  end

  def details
    params.require(:id)
    render json: Task.find(params[:id])
  end

  def message
    params.require(:id)
    params.require(:data)
    task = Task.find(params[:id])
    task.messages.create({user: current_user.id, data: params[:data]}) if(task.user_id.eql?(current_user.id) || current_user.tech)
    task.touch
  end
end
