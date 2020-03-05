# frozen_string_literal: true

class Update < ApplicationRecord
  belongs_to :novel, primary_key: "ncode", foreign_key: "ncode"
  # valications :time_zone, inclusion: { in: ActiveSupport::TimeZone.zones_map(&:name) }
  def self.extract_data(data)
    Update.find_or_create_by(
      ncode: data['ncode'],
      novel_updated_at: data['novelupdated_at'],
      general_all_no: data['general_all_no'],
      all_point: data['all_point'],
      length: data['length'],
      all_hyoka_cnt: data['all_hyoka_cnt'],
      global_point: data['global_point'],
      fav_novel_cnt: data['fav_novel_cnt'],
      review_cnt: data['review_cnt']
    )
  end

  def self.set_data(data)
    Update.find_or_create_by(
      ncode: data['ncode'],
      novel_updated_at: data['novelupdated_at'],
      general_all_no: data['general_all_no'],
      all_point: data['all_point'],
      length: data['length'],
      all_hyoka_cnt: data['all_hyoka_cnt'],
      global_point: data['global_point'],
      fav_novel_cnt: data['fav_novel_cnt'],
      review_cnt: data['review_cnt']
    )
  end

  def length_per_time
    length.to_f / novel_updated_at.to_f
  end

  def self.daily_data
    tmp_array = []
    array = []
    update_times = Update.all.pluck(:novel_updated_at)

    update_times.each do |update_time|
      hash = {}
      x = update_time.strftime('%Y-%m-%d')
      hash.store('date', x)
      tmp_array.push(hash)
    end
    tmp_array.uniq.each do |uniq|
      hash = uniq
      hash.store('r', tmp_array.count(uniq))
      array.push(hash)
    end
    array
  end

  def self.avg_daily_count
    data = Update.daily_data
    cnt = data.count
    update_times = Update.all.pluck(:novel_updated_at).count
    update_times / cnt
  end
end
