class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def marker_owner
        @marker = Marker.find(params[:id])
        User.find_by(id: @marker.user_id) == current_user
    end

    def signed_in?
        !!current_user
    end

    def current_user=(user)
        @current_user = user
        session[:user_id] = user.nil? ? nil : user.id
    end

    helper_method :current_user, :signed_in?, :marker_owner
end
