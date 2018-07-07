class VisitorController < ApplicationController
  def index
    #raise 'user signed in but looking at visitors' if user_signed_in?
    redirect_to(roster_path) if user_signed_in?
  end
end
