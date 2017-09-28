require 'zlib'
require 'benchmark'
require 'discordrb'
class Unnovel < ApplicationRecord
  STATUS = %w[daily weekly monthly yearly].freeze
  def intialize(_date = Date.today, _duration = 1.week)
    @data = data
  end

  def self.make_dataset(jsons)
    updates = []
    users = []
    novels = []
    jsons.count
    jsons.each do |json|
      js = ActiveSupport::JSON.decode(json)
      count = js.count
      js.each do |data|
        next if data['allcount'].present?
        updates << Update.extract_data(data)
        # Update.set_data(data)
        novels << Novel.extract_data(data)
        users << User.extract_data(data)
        count -= 1
        p count.to_s
      end
    end
    p "end"
    Benchmark.bm 10 do |r|
      r.report "Nantoka" do
        Update.import updates, on_duplicate_key_ignore: true
        Novel.import novels, on_duplicate_key_update: %i[title story genre big_genre ends novel_type]
        User.import users, on_duplicate_key_update: %i[userid writer]
      end
    end
  end

  def self.get_data
    before = Update.count
    text = "starting fetching updates"
    p text
    jsons = []
    url = ScoppConstant.get_url(1)
    uri = URI.parse(url)
    gzip = Net::HTTP.get(uri)
    jsons.push(ActiveSupport::Gzip.decompress(gzip))
    make_dataset(jsons)
    after = Update.count
    text = "update done!.\n #{after - before} update record(s) has been added!"
    p text
  end

  def self.calculate_point
    novels = Novel.joins(:updates).where(updates: { novel_updated_at: Date.today...Date.today + 1.day })
    p novels.first

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
