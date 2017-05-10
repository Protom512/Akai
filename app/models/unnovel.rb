require 'zlib'
class Unnovel < ApplicationRecord
    # has_one :novel
    STATUS=["daily","weekly","monthly","yearly"]
    def intialize(date=Date.today,duration =1.week)
        @data=data
    end   
    def self.get_data
        before=Update.count
        jsons=Array.new
        urls=Array.new
        urls.push(ScoppConstant.get_url(1))
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
        novels=Novel.joins(:updates).where(updates: {novel_updated_at:  Date.today...Date.today+1.day})   
        #daily
        novels.each{|novel|
            unnovel_0=Unnovel.new
            unnovel_1=Unnovel.new
            unnovel_2=Unnovel.new
            unnovel_3=Unnovel.new
            unnovel_0.calc_(Date.today,STATUS[0],novel)
            unnovel_1.calc_(Date.today,STATUS[1],novel)
            unnovel_2.calc_(Date.today,STATUS[2],novel)
            unnovel_3.calc_(Date.today,STATUS[3],novel)
        }
        #weekly
        #monthly
        #yearly
    end
end