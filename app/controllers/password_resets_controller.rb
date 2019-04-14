class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions.'
      redirect_to root_url
    else
      flash[:danger] = "There's nobody with that email here."
      render 'new'
    end
  end
end
