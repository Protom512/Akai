# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'zlib'
num=1
while num<=2001-500 do 
    url="http://api.syosetu.com/novelapi/api/?out=json&lim=500&start=#{num}&gzip=5"
    uri = URI.parse(url)
    gzip = Net::HTTP.get(uri)
    jsons=ActiveSupport::Gzip.decompress(gzip)
    js = ActiveSupport::JSON.decode(jsons)

    js.each do |data|
        

        Update.create(
            ncode: data['ncode'] , 
            length: data['length'] , 
            all_point: data['all_point'],
            all_hyoka_cnt: data['all_hyoka_cnt'], 
            global_point: data['global_point'], 
            fav_novel_cnt: data['fav_novel_cnt'], 
            review_cnt: data['review_cnt'], 
            novel_updated_at: data['novelupdated_at']
            
            )
        User.find_or_create_by(id: data['userid']).update(writer: data['writer'])
        # Novel.find_or_create_by(
        #     ncode: data['ncode'],
        #     title: data['title'],
        #     story: data['story'],
        #     user_id: data['userid'],
        #     genre: data['genre'],
        #     biggenre: data['biggenre'],
        #     end: data['end'],
        #     novel_type: data['novel_type'],
        #     general_all_no: data['general_all_no']
        #     ).update(
        #         ncode: data['ncode'],
        #         title: data['title'],
        #         story: data['story'],
        #         user_id: data['userid'],
        #         genre: data['genre'],
        #         biggenre: data['biggenre'],
        #         end: data['end'],
        #         novel_type: data['novel_type'],
        #         general_all_no: data['general_all_no']
        #     )
        
    end
    num+=500
end