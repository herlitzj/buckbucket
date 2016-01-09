class SessionsController < ApplicationController
    def create
        begin
            auth_hash = request.env['omniauth.auth']
            @user = User.find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
            session[:user_id] = @user.id
            flash[:success] = "Welcome, #{@user.name}!"
        rescue
            flash[:warning] = "There was an error while trying to authenticate you..."
        end
        # redirect_to root_path
        render text: request.env['omniauth.auth'].to_yaml
    end

    def destroy
        if current_user
            session.delete(:user_id)
            flash[:success] = 'See you!'
        end
        redirect_to root_path
    end
  
end