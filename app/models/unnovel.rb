class Unnovel < ApplicationRecord
    def intialize(date=Date.today,duration =1.week)
        @data
        
    end
    def self.calculate_point
        Update.order(:all_point).last(10)
    end
end
