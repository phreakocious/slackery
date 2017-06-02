require 'spec_helper'

describe Slackery::Commands::Ping do
  def app
    Slackery::Bot.instance
  end

  subject { app }

  it 'returns pong.' do
    expect(message: "#{SlackRubyBot.config.user} ping", channel: 'channel').to respond_with_slack_message('pong.')
  end
end
