class User < ApplicationRecord
  has_many :novel
  def self.extract_data(data)
    User.create(
      writer: data['writer']
    )
  end

  def self.set_data(data)
    User.find_or_create_by(id: data['userid']).update_attributes(writer: data['writer'])
  end
end
