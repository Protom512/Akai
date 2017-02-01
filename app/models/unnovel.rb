require 'zlib'
class Unnovel < ApplicationRecord
    def intialize(date=Date.today,duration =1.week)
        @data=data
        
    end   
    def self.get_data
        jsons=Array.new
        urls=Array.new
        urls.push(ScoppConstant.get_url(500))
        urls.push(ScoppConstant.get_url(1000))
        urls.push(ScoppConstant.get_url(1500))
        urls.push(ScoppConstant.get_url(2000))
        Parallel.each(urls,in_threads: 4){|url|
            uri = URI.parse(url)
            gzip = Net::HTTP.get(uri)
            jsons.push(ActiveSupport::Gzip.decompress(gzip))
            
        }
        jsons.each{|json|
        js = ActiveSupport::JSON.decode(json)
            js.each do |data|
                if data['allcount'].present?
                    next
                end
                User.set_data(data)
                Novel.set_data(data)
                Update.set_data(data)
            end
        }
    end
    def self.calculate_point
        
        Update.order(:all_point).last(10)
        
    end
end
