module ApplicationHelper

    #change time zone from server to be in EST and proper display
    def format_time time
        time.to_formatted_s(:long)
    end 

end
