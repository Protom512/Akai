# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
uri = URI.parse('http://api.syosetu.com/novelapi/api/?out=json&lim=500$gzip=5')
jsons = Net::HTTP.get(uri)
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
    if User.find_by_id(data['userid']).present?
        
        User.find_by_id(data['userid']).update(
        writer: data['writer']
        )
    else
        User.create(
            id: data['userid'],
            writer: data['writer']
        )
    end
    end