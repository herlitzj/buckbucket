class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def current_user
      @current_user = User.find(session[:user_id])
    end

    def marker_owner
        @marker = Marker.find(params[:id])
        User.find_by(id: @marker.user_id) == current_user
    end

    helper_method :current_user, :marker_owner
end
