require 'zlib'
class Unnovel < ApplicationRecord
    def intialize(date=Date.today,duration =1.week)
        @data=data
        
    end   
    def self.get_data
        jsons=Array.new
        num=1
        while num<=2001-500 do
            url=ScoppConstant.get_url(num)
            uri = URI.parse(url)
            gzip = Net::HTTP.get(uri)
            jsons.push(ActiveSupport::Gzip.decompress(gzip))
            num+=500
        end
        p jsons
        jsons.each{|json|
            js = ActiveSupport::JSON.decode(json)
            js.each do |data|
                if data['allcount'].present?
                    next
                end
                user=User.set_data(data)
                nove=Novel.set_data(data)
                update=Update.set_data(data)
            end
        }
    end
    def self.calculate_point
        Update.order(:all_point).last(10)
    end
end
