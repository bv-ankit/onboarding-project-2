class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
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
end
