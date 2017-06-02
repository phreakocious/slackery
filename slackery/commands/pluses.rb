require 'stringio'
require 'table_print'

module Slackery
  module Commands

    class Pluses < SlackRubyBot::Commands::Base
      include DataMapper::Resource

      property :keyword,    String,  required: true, key: true
      property :pluses,     Integer, required: true, default: 0
      property :created_at, DateTime
      property :updated_at, DateTime

      TOP_N = 5

      def self.reply(client, data, reply)
        client.say(text: reply, channel: data.channel)
      end

      def sayPluses(client, data)
        Pluses.reply client, data, "Thanks, <@#{data.user}>!  *#{keyword}* has #{pluses} pluses!"
      end

      command '++' do |client, data, match|
        record = first_or_create(keyword: match[:expression])
        record.update(pluses: record.pluses + 1)
        record.sayPluses client, data
      end

      command '--', '—' do |client, data, match|
        record = first_or_create(keyword: match[:expression])
        #TODO: Allow a user to remove their own plus... Requires looking up the stupid user ID......
        record.sayPluses client, data
      end

      command 'pluses', 'kudos' do |client, data, match|
        records = all(order: [:pluses.desc], limit: TOP_N)
        tp.set :capitalize_headers, false
        result = StringIO.new
        tp.set :io, result
        tp records.to_a, :keyword, :pluses
        tp.clear :io

        reply client, data, "```#{result.string}```"
      end

      help do
        title 'pluses'
        desc 'persistent kudos for people and things.'
      end
    end

  end
end
