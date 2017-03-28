require 'washbullet'
class ScoppConstant < ApplicationRecord
    include ActiveAttr::Attributes
    PUSHBULLET_API_KEY =  ENV['PUSHBULLET_KEY']
    def self.get_url(num)
            url="http://api.syosetu.com/novelapi/api/?out=json&lim=500&start=#{num}&gzip=5"
        url
    end
    
    def self.getUserId (token)

        api_response = `curl -s -u #{token}: https://api.pushbullet.com/v2/users/me`
        userId = JSON.parse(api_response)

        return userId["client_iden"]
    end
    
    def self.pushbullet_note(title,note)
        user_id=getUserId(PUSHBULLET_API_KEY)
        client = Washbullet::Client.new(PUSHBULLET_API_KEY)
        client.push_note(
            receiver:   :client,
            identifier: user_id,
            params: {
                title: title,
                body:  note
            }
            )
    end
end
