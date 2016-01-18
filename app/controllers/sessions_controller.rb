class SessionsController < ApplicationController
    def create
        auth_hash = request.env['omniauth.auth']
        
        # Find an identity here
        @identity = Identity.find_with_omniauth(auth_hash)

        # If no identity was found, create a brand new one here
        if @identity.nil?
            @identity = Identity.create_with_omniauth(auth_hash)
        end

        if signed_in?
            if @identity.user_id == current_user
                # User is signed in so they are trying to link an identity with their
                # account. But we found the identity and the user associated with it 
                # is the current user. So the identity is already associated with 
                # this user. So let's display an error message.
                redirect_to root_url, notice: "Already linked that account!"
            else
                # The identity is not associated with the current_user so lets 
                # associate the identity
                @identity.user_id = current_user
                @identity.save()
                redirect_to root_url, notice: "Successfully linked that account!"
            end
        else
            if @identity.user_id.present?
                # The identity we found had a user associated with it so let's 
                # just log them in here
                self.current_user = @identity.user_id
                redirect_to root_url, notice: "Signed in!"
            else
                begin
                    @user = User.create_from_omniauth(auth_hash)
                    session[:user_id] = @user.id
                    flash[:success] = "Welcome to BuckBucket, #{@user.name}!"
                rescue
                    flash[:warning] = "There was an error while trying to authenticate you..."
                end
                redirect_to root_path
                # render text: request.env['omniauth.auth'].to_json
            end
        end

    end

    def destroy
        if current_user
            session.delete(:user_id)
            flash[:success] = 'Signed Out!'
        end
        redirect_to root_path
    end
  
end