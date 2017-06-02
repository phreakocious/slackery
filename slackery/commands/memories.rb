module Slackery
  module Commands

    class Memories < SlackRubyBot::Commands::Base
      include DataMapper::Resource

      property :id,         Serial
      property :keyword,    String, required: true
      property :memory,     String, required: true
      property :created_at, DateTime
      property :updated_at, DateTime

      def self.reply(client, data, reply)
        client.say(text: reply, channel: data.channel)
      end

      def self.randomMemory(keyword)
        all(keyword: keyword).sort_by{rand}.first()
      end

      def self.listMemories(limit = 10)
        all().sort_by{rand}.first(limit).map(&:keyword).uniq
      end

      command 'memories' do |client, data, match|
        unless match[:expression]  # User didn't specify a keyword
          reply client, data, 'For what?'
          next
        end

        reply client, data,all(keyword: match[:expression]).map(&:memory).uniq.join("\n")
      end

      command 'remember' do |client, data, match|
        unless match[:expression]  # User didn't specify a keyword
          records = listMemories.join ', '
          reply client, data, "I remember lots of things, ask about these:\n#{records}"
          next
        end

        keyword, z, memory = match[:expression].partition ' '

        # Add memory if one was specified
        unless memory.empty?
          record = first_or_create(keyword: keyword, memory: memory)
          reply client, data, "Remembered: _#{keyword}_ - #{memory}"
          next
        end

        record = randomMemory(keyword)

        if record
          reply client, data,record.memory
        else
          reply client, data, "Sorry, I don't know _#{keyword}_ yet.  This should never happen!"
        end
      end

      help do
        title 'memories'
        desc 'the sweetest.'
      end
    end

  end
end
