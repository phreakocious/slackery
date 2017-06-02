module Slackery
  module Commands
    class Ping < SlackRubyBot::Commands::Base

      def self.call(client, data, match)
        client.say(text: '#{data.user} - pong.', channel: data.channel)
      end
    end
  end
end
