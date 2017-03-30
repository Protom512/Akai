require 'washbullet'
class ScoppConstant < ApplicationRecord
    include ActiveAttr::Attributes
    PUSHBULLET_API_KEY =  ENV['PUSHBULLET_KEY']
    def self.get_url(num)
            url="http://api.syosetu.com/novelapi/api/?out=json&lim=500&start=#{num}&gzip=5"
        url
    end
    
    def self.pushbullet_note(title,note)
        client = Washbullet::Client.new(PUSHBULLET_API_KEY)
        client.push_note(
            receiver:   :client,
            identifier: nil,
            params: {
                title: title,
                body:  note
            }
            )
    end
end
