class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone: params[:session][:phone])||User.find_by(phone_short: params[:session][:phone])
    p user
    if user && user.authenticate(params[:session][:password])
      p "ok!!"
      flash[:danger] = "ok!!"
      log_in user
      redirect_to user
    else
      p "no!!"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
