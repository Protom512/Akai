require 'zlib'
class Unnovel < ApplicationRecord
    has_one :novel
    STATUS=["daily","weekly","monthly","yearly"]
    def intialize(date=Date.today,duration =1.week)
        @data=data
        
    end   
    def self.get_data
        jsons=Array.new
        urls=Array.new
        urls.push(ScoppConstant.get_url(1))
        urls.push(ScoppConstant.get_url(501))
        urls.push(ScoppConstant.get_url(1001))
        urls.push(ScoppConstant.get_url(1501))
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
    def calc_(date,duration,novel)
        self.date=date
        self.novel_id=novel.id
        self.duration=duration
        p duration
        if duration==STATUS[0]
            _duration=1.day
        elsif duration==STATUS[1]
            _duratino=1.week
        elsif duration==STATUS[2]
            _duration=1.month
        elsif duration==STATUS[3]
            _duration=1.year
        end
        p "calculation"
        _point=0
        
        p "t1"
        p date
        end_date=date + 1.day
        start_date=date  + 1.day- _duration
        p "#{start_date} #{end_date}"
        updates=novel.updates.where(novel_updated_at: start_date...end_date)
        binding.pry
        p "te2"
        _point+=updates.count.to_f
        p "te3"
        _point+=updates.last.length_per_time-updates.first.length_per_time
        p "te4"
        diff_length=(updates.last.length-updates.first.length)
        p "te5"
        _point+=diff_length.to_f/_duration.to_f
        self.points=_point
        
    end
end

