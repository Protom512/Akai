class Novel < ApplicationRecord
    has_many :updates, primary_key: "ncode",foreign_key: "ncode"
    belongs_to :user, foreign_key: "ncode"
end
