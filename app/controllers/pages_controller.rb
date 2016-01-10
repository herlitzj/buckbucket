class PagesController < ApplicationController
    def index
        @marker = Marker.new
    end
end