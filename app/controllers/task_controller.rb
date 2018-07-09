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
      if m['user'] > 0
        u=User.find(m['user'])
        response['tech']=u.tech;
        response['user']=u.email;
      else
        response['tech']=true;
        response['user']='Server'
      end
      response['created_at']=distance_of_time_in_words(Time.now, m['created_at'])+' ago'
      response['data']  = (m['data'].split("\r\n").map {|e| "<p class='lead card-text pl-5 pr-5'>#{Rinku.auto_link e}</p>" }).join
      response
    end
  end

  def complete
    params.require(:id)
    task = Task.find(params[:id])
    task.update({state: :completed}) if (task.user_id.eql?(current_user.id) || current_user.tech) && task.state.eql?("active")
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
    if task.user_id.eql?(current_user.id) || current_user.tech
      m = task.messages.create({user: current_user.id, data: params[:data]})
      task.touch
      data = "<div class=\"card mt-1 mb-1 #{current_user.tech ? "border-secondary" : "border-primary"}\">";
      data += "<div class=\"card-header #{current_user.tech ? "bg-secondary" : "bg-primary"}\"><span class=\"text-dark\">#{current_user.email} says: </span><span class=\"float-right\">#{distance_of_time_in_words(Time.now, m.created_at)}</span></div>"
      data += "<div class=\"card-body\">#{(m.data.split("\r\n").map {|e| "<p class='lead card-text pl-5 pr-5'>#{Rinku.auto_link e}</p>" }).join}</div>"
      ActionCable.server.broadcast 'dialog_notifications_channel', task: params[:id], action: :dialog_update, data: data
    end
    head :no_content
  end
end
