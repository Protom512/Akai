require 'zlib'
class Unnovel < ApplicationRecord
  STATUS = %w[daily weekly monthly yearly].freeze
  def intialize(_date = Date.today, _duration = 1.week)
    @data = data
  end

  def self.get_data
    bot = Discordrb::Bot.new token: ENV['DISCORD_TOKEN'], client_id: ENV['DISCORD_CLIENT_ID']
    bot.run :async
    bot.send_message(ENV['DISCORD_CHANNEL_ID'], "starting fetching updates")
    before = Update.count
    jsons = []
    urls = []
    urls.push(ScoppConstant.get_url(1))
    Parallel.each(urls, in_threads: 4) do |url|
      uri = URI.parse(url)
      gzip = Net::HTTP.get(uri)
      jsons.push(ActiveSupport::Gzip.decompress(gzip))
    end
    jsons.each do |json|
      js = ActiveSupport::JSON.decode(json)
      js.each do |data|
        next if data['allcount'].present?
        User.set_data(data)
        Novel.set_data(data)
        Update.set_data(data)
      end
    end
    after = Update.count
    text = "update done!.\n #{after - before} update record(s) has been added!"
    bot.send_message(ENV['DISCORD_CHANNEL_ID'], text)
    bot.stop
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
