# require 'washbullet'

require 'discordrb'
class ScoppConstant < ApplicationRecord
  include ActiveAttr::Attributes
  PUSHBULLET_API_KEY = ENV['PUSHBULLET_KEY']
  def self.get_url(num)
    "http://api.syosetu.com/novelapi/api/?out=json&lim=500&start=#{num}&gzip=5"
  end

  def self.pushbullet_note(title, note)
    client = Washbullet::Client.new(PUSHBULLET_API_KEY)
    client.push_note(
      receiver:   :client,
      identifier: nil,
      params: {
        title: title,
        body:  note
      }

    )
  end

  def self.update_notification(message)
    bot = Discordrb::Bot.new token: ENV['DISCORD_TOKEN'], client_id: ENV['DISCORD_CLIENT_ID']
    bot.run :async
    bot.send_message(ENV['DISCORD_CHANNEL_ID'], message)
    bot.stop
  end
end
