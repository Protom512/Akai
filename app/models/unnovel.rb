require 'zlib'
class Unnovel < ApplicationRecord
  STATUS = %w[daily weekly monthly yearly].freeze
  def intialize(_date = Date.today, _duration = 1.week)
    @data = data
  end

  def self.make_dataset(jsons)
    updates = []
    users = []
    novels = []
    jsons.each do |json|
      js = ActiveSupport::JSON.decode(json)
      js.each do |data|
        next if data['allcount'].present?
        updates << Update.extract_data(data)
        novels << Novel.extract_data(data)
        users << User.extract_data(data)
      end
    end
    Update.import updates
    Novel.import novels, on_duplicate_key_update: %i[title story genre big_genre ends novel_type]
    User.import users, on_duplicate_key_update: [:writer]
  end

  def self.get_data
    before = Update.count
    text = "starting fetching updates"
    ScoppConstant.update_notification(text)
    jsons = []
    urls = []
    urls.push(ScoppConstant.get_url(1))
    Parallel.each(urls, in_threads: 4) do |url|
      uri = URI.parse(url)
      gzip = Net::HTTP.get(uri)
      jsons.push(ActiveSupport::Gzip.decompress(gzip))
    end
    make_dataset(jsons)
    after = Update.count
    text = "update done!.\n #{after - before} update record(s) has been added!"
    ScoppConstant.update_notification(text)
  end

  def self.calculate_point
    novels = Novel.joins(:updates).where(updates: { novel_updated_at: Date.today...Date.today + 1.day })

    # daily
    novels.each do |novel|
      unnovel_0 = Unnovel.new
      unnovel_1 = Unnovel.new
      unnovel_2 = Unnovel.new
      unnovel_3 = Unnovel.new
      unnovel_0.calc_(Date.today, STATUS[0], novel)
      unnovel_1.calc_(Date.today, STATUS[1], novel)
      unnovel_2.calc_(Date.today, STATUS[2], novel)
      unnovel_3.calc_(Date.today, STATUS[3], novel)
    end

    # weekly
    # monthly
    # yearly
  end
end
