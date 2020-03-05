# frozen_string_literal: true

class Novel < ApplicationRecord
  has_many :updates, primary_key: "ncode", foreign_key: "ncode"
  belongs_to :user, primary_key: "userid", foreign_key: "user_id"
  # belongs_to :unnovel
  validates :ncode, uniqueness: true
  def self.extract_data(data)
    Novel.create(
      ncode: data['ncode'],
      title: data['title'],
      story: data['story'],
      user_id: data['userid'],
      genre: data['genre'],
      big_genre: data['biggenre'],
      ends: data['end'],
      novel_type: data['novel_type']
    )
  end

  def self.set_data(data)
    novel = Novel.find_or_create_by(
      ncode: data['ncode']
    )
    novel.update_attributes(
      title: data['title'],
      story: data['story'],
      user_id: data['userid'],
      genre: data['genre'],
      big_genre: data['biggenre'],
      ends: data['end'],
      novel_type: data['novel_type']
    )
    novel
  end
end
