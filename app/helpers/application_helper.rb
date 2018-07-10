module ApplicationHelper

  # Devise helper to allow us to have members with the tech flag
  def user_is_tech?
    current_user.tech
  end

end
