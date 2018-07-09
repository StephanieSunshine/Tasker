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
    @response['body']  = (@response['body'].split("\r\n").map {|e| "<p class='lead'>#{e}</p>" }).join
  end

  def dialog
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

end
