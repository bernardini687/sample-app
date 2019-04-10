class SessionsController < ApplicationController
  def new; end

  def create
    # Set @user so users_login_test can retrieve it with the assigns method
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      if params[:session].values.uniq == ['']
        flash.now[:danger] = 'NOOOOO! Type something!'
      elsif @user
        flash.now[:danger] = 'NOOOOO! Bad password!'
      else
        flash.now[:danger] = 'NOOOOO! Bad email!'
      end
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
