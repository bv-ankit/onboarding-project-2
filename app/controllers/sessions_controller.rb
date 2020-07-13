class SessionsController < ApplicationController
  def new
    redirect_to root_path if signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      signin user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:danger] = "Invalid Credentials"
      render 'new'
    end
  end

  def destroy
    signout if signed_in?
    redirect_to root_url
  end

  private

  def signin_params
    params.require(:signin).permit(:email, :password)
  end
end
