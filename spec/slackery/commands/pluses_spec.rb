require 'spec_helper'

describe Slackery::Commands::Pluses do
  def app
    Slackery::Bot.instance
  end

  subject { app }

  it 'returns pluses:' do
    expect(message: "#{SlackRubyBot.config.user} pluses help", channel: 'channel').to respond_with_slack_message('pluses:.*')
  end
end

