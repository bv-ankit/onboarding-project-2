module SessionsHelper
    def signin(user)
        session[:user_id] = user.id
    end

    def current_user
		@current_user ||= User.find_by(id: session[:user_id])
    end
    
    def signed_in?
        !current_user.nil?
    end

    def signout
        session.delete(:user_id)
        @current_user = nil
    end

    def current_user?(user)
        user = current_user
    end

    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end