class ClaimedMarker < ActiveRecord::Base

    def self.set_to_paid claim
        claim.paid = true
        claim.save
    end

end
