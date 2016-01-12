class Marker < ActiveRecord::Base
    belongs_to :user

    def self.extract_markers_json
        all_markers = Marker.all
        marker_array = []

        all_markers.each do |marker|
            marker_hash = {:lat=>marker.lat.to_f, :lng=>marker.lon.to_f, :id=>marker.id, :description=>marker.description,
                            :title=>marker.title, }
            marker_array.append(marker_hash)
        end

        return marker_array
    end
end
