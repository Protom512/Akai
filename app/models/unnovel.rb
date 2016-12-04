class Unnovel < ApplicationRecord
    def novelapi
        uri = URI.parse('http://api.syosetu.com/novelapi/api/?out=json&lim=500$gzip=5')
        json = Net::HTTP.get(uri)
        result = JSON.parse(json)
        result2= JSON.pretty_generate(result)
        return result2
    end
end
