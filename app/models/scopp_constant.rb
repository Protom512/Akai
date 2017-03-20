class ScoppConstant < ApplicationRecord
    def self.get_url(num)
        url="http://api.syosetu.com/novelapi/api/?out=json&lim=500&start=#{num}&gzip=5"
        url
    end
end
