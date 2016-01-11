class PagesController < ApplicationController
    def index
        @marker = Marker.new


        # TURN THIS INTO A CUSTOM MODEL FUNCTION THAT RETURNS THE INFO YOU WANT
        @all_markers = []
        Marker.all.each do |marker|
           # marker.id mar.id
           lat = marker.lat
           lon = marker.lon
           id = marker.id
           description = marker.description
           @all_markers.append(marker)
        end

        gon.all_markers = @all_markers.to_json
    end
end