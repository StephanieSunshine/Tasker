class MemberController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :authenticate_user!, :setUser

  def setUser
    cookies[:user_id]=current_user.id
    cookies[:is_tech]=current_user.tech
  end

  def index
    @task = Task.new
  end

  def add
    params.require(:task).permit(:title, :body)
    #raise params.inspect
    current_user.tasks.create({title: params[:task][:title], body: params[:task][:body]})
    redirect_to roster_url
  end

  def update
    params.require(:task).permit(:id, :title, :body)
    task = Task.find(params[:task][:id])
    task.update({title: params[:task][:title], body: params[:task][:body]}) if(task.user_id.eql?(current_user.id) || current_user.tech)
    redirect_to roster_url
  end



  def getCurrentUserId
    render json: current_user.id
  end

  def getNextTask
    render json: Task.where(state: :queued).order(:created_at).limit(1) if current_user.tech.eql?(true)
  end

  def closeTask
  end

  def rosterFeed
    results = []

    Task.where(state: :completed).order(:created_at).limit(5).to_a.each {|e| results.push(e) }
    Task.where(state: :active).order(:created_at).to_a.each {|e| results.push(e) }
    Task.where(state: :queued).order(:created_at).to_a.each {|e| results.push(e) }

    results.map! do |e|
      result={}
      result[:id]=e.id
      result[:created_by]=User.find(e.user_id).email
      result[:title]=e.title
      result[:state]=e.state
      result[:assigned_to] = e.assigned_to.nil? ? "None" : User.find(e.assigned_to).email
      result[:last_update]=distance_of_time_in_words(Time.now, e.updated_at)
      result[:age]=distance_of_time_in_words(Time.now, e.created_at)
      result
    end

    render json: results
  end
end
