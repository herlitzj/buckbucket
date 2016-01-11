class PagesController < ApplicationController
    def index
        @marker = Marker.new

        @all_markers_json = Marker.extract_markers_json
        gon.all_markers_json = @all_markers_json
    end
end