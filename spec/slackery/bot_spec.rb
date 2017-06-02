require 'spec_helper'

describe Slackery::Bot do
  def app
    Slackery::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'
end