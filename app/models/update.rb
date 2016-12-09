class Update < ApplicationRecord
    belongs_to :novel, foreign_key: "ncode"

end
