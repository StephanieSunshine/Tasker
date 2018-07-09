module ApplicationHelper

  # Devise helper to allow us to have members with the tech flag
  def user_is_tech?
    current_user.tech
  end

  # HTML header generator helper for DRY
  def generate_header(title = "", body = "")
    data = "<div class='px-3 py-3 pt-md-5 pb-md-4 mx-auto'><h1 class='display-4 text-center'>#{title}</h1><p class='lead'>#{body}</p></div>"
    data.html_safe
  end

end
