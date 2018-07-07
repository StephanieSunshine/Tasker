class MemberController < ApplicationController
  
  def index
    redirect_to visitor_path if !user_signed_in?
  end

  def addTask
  end

  def changeTask
  end

  def assignTask
  end
end
