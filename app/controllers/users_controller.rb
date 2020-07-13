class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    redirect_to root_path if signed_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      signin @user
      redirect_to @user
    else
      flash[:register_errors] = @user.errors.full_messages
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
