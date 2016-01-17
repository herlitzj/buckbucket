module MarkersHelper

    def get_user_name user_id
        User.find(user_id).name
    end

    #change time zone from server to be in EST and proper display
    def format_time time
        time.to_formatted_s(:long)
    end 
end
