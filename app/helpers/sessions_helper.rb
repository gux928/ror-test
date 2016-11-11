module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def login_check
    if !logged_in?
      store_location
      redirect_to login_path
    end
  end

  def redirect_back_or_index
    redirect_to(session[:forwarding_url] || root_path)
    session.delete(:forwarding_url)
  end
# 存储以后需要的地址
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
