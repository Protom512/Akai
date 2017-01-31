class Update < ApplicationRecord
    belongs_to :novel, primary_key: "ncode",foreign_key:"ncode"
    def self.set_data(data)
        Update.find_or_create_by(
            ncode: data['ncode'] ,
            novel_updated_at: data['novelupdated_at'],
            general_all_no: data['general_all_no'],
            all_point: data['all_point'],
            length: data['length'],
            all_hyoka_cnt: data['all_hyoka_cnt'],
            global_point: data['global_point'],
            fav_novel_cnt: data['fav_novel_cnt'],
            review_cnt: data['review_cnt'],
            )
            
    end
end
