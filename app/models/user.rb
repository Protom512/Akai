class User < ApplicationRecord
    has_many :novel
    # has_many :updates , :through=> :novel

    def self.set_data(data)
        User.find_or_create_by(id: data['userid']).update_attributes(writer: data['writer'])
    end
end
