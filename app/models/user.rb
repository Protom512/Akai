# frozen_string_literal: true

class User < ApplicationRecord
  has_many :novel, primary_key: "userid", foreign_key: "user_id"
  def self.extract_data(data)
    User.create(
      userid: data['userid'],
      writer: data['writer']
    )
  end

  def self.set_data(data)
    User.find_or_create_by(id: data['userid']).update_attributes(writer: data['writer'])
  end
end
