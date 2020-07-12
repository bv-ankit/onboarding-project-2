class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			signin user
			redirect_back_or user
		else
			flash[:signin_errors] = ['Invalid Credentials']
			redirect_to 'signin'
		end
	end
	
	def destroy
		signout
		redirect_to root_url
	end

	private

	def signin_params
		params.require(:signin).permit(:email, :password)
	end
end
