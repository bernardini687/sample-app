class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # redirect_to user
      # flash[:success] = 'YAAAAAY!'
    else
      if user
        flash[:danger] = 'NOOOOO! Bad password!'
      else
        flash[:danger] = 'NOOOOO! Bad email!'
      end
      render 'new'
    end
  end

  def destroy; end
end
