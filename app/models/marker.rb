class Marker < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :title, presence: true, length: { maximum: 60 }
    validates :description, presence: true

    def self.extract_markers_json
        all_markers = Marker.all
        marker_array = []

        all_markers.each do |marker|
            marker_hash = {:lat=>marker.lat.to_f, :lng=>marker.lon.to_f, :id=>marker.id, :description=>marker.description,
                            :title=>marker.title, :user_id=>marker.user_id }

            if marker.user_id.nil? or marker.user_id == 0
                marker_hash[:icon_url] = 'http://maps.google.com/mapfiles/kml/pal3/icon63.png'
            else
                marker_hash[:icon_url] = 'http://maps.google.com/mapfiles/kml/pal2/icon50.png'
            end

            marker_array.append(marker_hash)
        end

        return marker_array
    end
end
