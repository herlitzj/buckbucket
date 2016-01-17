class ClaimedMarker < ActiveRecord::Base

    def self.set_to_paid claim_id
        marker = ClaimedMarker.find(claim_id)
        marker.paid = true
        marker.save
    end
end
