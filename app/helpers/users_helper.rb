module UsersHelper

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !!current_user
  end
end
