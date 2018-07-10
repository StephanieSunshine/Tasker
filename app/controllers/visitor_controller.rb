class VisitorController < ApplicationController
  def index
    redirect_to(roster_path) if user_signed_in?
  end
end
