class Update < ApplicationRecord
    belongs_to :novels, foreign_key: "ncode"

end
